class WebScrapingTasksController < ActionController::API
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
    service = CreateWebScrapingTaskService.new(params[:url_for_scraping], params[:state], creator_id)
    web_scraping_task_id = service.perform
    
    if web_scraping_task_id
      HTTParty.post(
        "http://web_scraping_microservice_api:7000/web_scraping/web_motors",
        read_timeout: 300,
        body: {
          token: params[:token],
          web_scraping_task_id: web_scraping_task_id,
          url_for_scraping: params[:url_for_scraping],
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      send_response("Task created!", 201)
    else
      send_response("Error creating task! The data provided was repeated or invalid, please check and try again.", 500)
    end
  end

  def get_a_task
    service = GetWebScrapingTaskDataService.new(
      params[:web_scraping_task_id]
    )

    user_task = service.perform
    
    if user_task
      send_response_with_task("User task found!", 200, user_task)
    else
      send_response("User task not found!", 404)
    end
  end 

  def update
    service = UpdateWebScrapingTaskService.new(
      params[:web_scraping_task_id],
      params[:state]
    )

    if service.perform
      send_response("User task updated!", 200)
    else
      send_response("Error updating user task!", 500)
    end    
  end

  def delete
    service = DeleteWebScrapingTaskService.new(
      params[:web_scraping_task_id]
    )

    if service.perform
      HTTParty.delete(
        "http://notification_microservice_api:2000/delete_all_notifications_related_to_web_scraping_task",
        body: {
          token: params[:token],
          web_scraping_task_id: params[:web_scraping_task_id],
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )

      send_response("User task deleted!", 200)
    else
      send_response("Error deleting user task!", 500)
    end  
  end
end
