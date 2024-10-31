class TasksController < ActionController::API
  before_action :authorize_user, except: :api_message

  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def api_message
    send_response("Hello! This is the microservice for TASKS", 200)
  end

  def is_given_token_valid(given_token)
    authentication_microservice_response = HTTParty.get("http://authentication_microservice_api:5000/users/get_data?token=#{given_token}")
    authentication_microservice_response.code == 200
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def get_all_tasks
    tasks = UserTask.all + WebScrapingTask.all
    tasks.sort_by! {|task| task[:created_at]}
    tasks.reverse!

    if tasks
      render json: {tasks: tasks}, status: 200
    else
      send_response("Error getting tasks!", 500)
    end
  end
end
