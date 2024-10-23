class TasksController < ActionController::API
  before_action :authorize_user, except: :api_message

  def send_response(message, code)
    render json: {APIresponse: message}, status: code
  end

  def api_message
    send_response("Hello! This is the microservice for TASKS", 200)
  end

  def is_given_token_valid(given_token)
    authentication_microservice_response = HTTParty.get("http://authentication_microservice_api:5000/users/valid_token?token=#{given_token}")
    authentication_microservice_response.code == 200
  end

  def authorize_user
    send_response("Token is invalid! User not found!", 404) unless is_given_token_valid(params[:token])
  end

  def get_all_user_tasks
    tasks = Task.where(user_id: params[:token])
    render json: tasks
  end

  def get_a_task
    task = Task.find(params[:id])

    if task
      render json: task
    else
      send_response("Task not found!", 404)
    end
  end

  def create
    new_task = Task.new(
      description: params[:description],
      user_id: params[:token],
      state: params[:state],
      task_type: params[:task_type],
      url_for_scraping: params[:url_for_scraping],
    )

    if new_task.save
      send_response("Task created!", 201)
    else
      send_response("Error creating task!", 500)
    end
  end

  def edit
    task = Task.find(params[:id])

    unless task
      send_response("Task not found!", 404)
      return
    end

    task.update(
      description: params[:description],
      task_type: params[:type],
      state: params[:state],
      url_for_scraping: params[:url_for_scraping],
    )

    send_response("Task updated!", 200)
  end

  def delete
    task = Task.find(params[:id])

    unless task
      send_response("Task not found!", 404)
      return
    end

    task.destroy
    send_response("Task deleted!", 200)
  end
end
