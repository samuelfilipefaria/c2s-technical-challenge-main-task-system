class TasksController < ActionController::API
  def api_message
    render json: {message: "Olá! Este é o microserviço para TAREFAS"}
  end

  def get_all_tasks
  end

  def get_a_task
  end

  def create
  end

  def edit
  end

  def delete
  end
end
