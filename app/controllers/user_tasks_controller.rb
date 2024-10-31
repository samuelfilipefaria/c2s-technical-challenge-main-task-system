class UserTasksController < ActionController::API
  before_action :authorize_user

  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def send_response_with_task(message, code, task)
    render json: {APIresponse: message, task: task}, status: code
  end

  def is_given_token_valid(given_token)
    authentication_microservice_response = HTTParty.get("http://authentication_microservice_api:5000/users/get_data?token=#{given_token}")
    authentication_microservice_response.code == 200
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def create
    creator_id = HTTParty.get("http://authentication_microservice_api:5000/users/get_user_id?token=#{params[:token]}")["userId"]
    service = CreateUserTaskService.new(params[:description], params[:state], creator_id)
    user_task_id = service.perform

    if user_task_id
      HTTParty.post(
        "http://notification_microservice_api:2000/create_user_action_notification",
        body: {
          token: params[:token],
          user_action: "created",
          user_task_id: user_task_id,
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      send_response("Task created!", 201)
    else
      send_response("Error creating task!", 500)
    end
  end

  def get_a_task
    service = GetUserTaskDataService.new(
      params[:user_task_id]
    )

    user_task = service.perform
    
    if user_task
      send_response_with_task("User task found!", 200, user_task)
    else
      send_response("User task not found!", 404)
    end
  end 

  def update
    service = UpdateUserTaskService.new(
      params[:user_task_id],
      params[:description],
      params[:state]
    )

    if service.perform
      HTTParty.post(
        "http://notification_microservice_api:2000/create_user_action_notification",
        body: {
          token: params[:token],
          user_action: "updated",
          user_task_id: params[:user_task_id],
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      send_response("User task updated!", 200)
    else
      send_response("Error updating user task!", 500)
    end    
  end

  def delete
    service = DeleteUserTaskService.new(
      params[:user_task_id]
    )

    if service.perform
      HTTParty.delete(
        "http://notification_microservice_api:2000/delete_all_notifications_related_to_user_task",
        body: {
          token: params[:token],
          user_task_id: params[:user_task_id],
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      send_response("User task deleted!", 200)
    else
      send_response("Error deleting user task!", 500)
    end  
  end
end
