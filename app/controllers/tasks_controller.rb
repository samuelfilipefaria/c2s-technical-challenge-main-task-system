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
    render json: tasks
  end

  # def create
  #   new_task = Task.new(
  #     description: params[:description],
  #     user_id: params[:token],
  #     state: params[:state],
  #     task_type: params[:task_type],
  #     url_for_scraping: params[:url_for_scraping],
  #   )

  #   if new_task.save
  #     send_response("Task created!", 201)
  #     HTTParty.post('http://notification_microservice_api:2000/send_notification', body: {
  #       token: params[:token],
  #       task_description: new_task.description,
  #       operation: "created",
  #       task_id: new_task.id,
  #       scraped_data: "",
  #     }.to_json, headers: { 'Content-Type' => 'application/json' })

  #     if new_task.task_type == "Web Scraping"
  #       HTTParty.post('http://web_scraping_microservice_api:7000/scrape_data', body: {
  #         token: params[:token],
  #         task_id: new_task.id,
  #         url_for_scraping: new_task.url_for_scraping,
  #       }.to_json, headers: { 'Content-Type' => 'application/json' })
  #     end

  #   else
  #     send_response("Error creating task!", 500)
  #   end
  # end

  # def edit
  #   task = Task.find(params[:id])

  #   unless task
  #     send_response("Task not found!", 404)
  #     return
  #   end

  #   task.update(
  #     description: params[:description],
  #     task_type: params[:task_type],
  #     state: params[:state],
  #     url_for_scraping: params[:url_for_scraping],
  #   )

  #   send_response("Task updated!", 200)
  #   HTTParty.post('http://notification_microservice_api:2000/send_notification', body: {
  #     token: params[:token],
  #     task_description: task.description,
  #     operation: "edited",
  #     task_id: task.id,
  #     scraped_data: "",
  #   }.to_json, headers: { 'Content-Type' => 'application/json' })
  # end
end
