class TasksController < ActionController::API
  def api_message
    render json: {message: "Olá! Este é o microserviço para TAREFAS"}
  end

  def get_all_user_tasks
    tasks = Task.where(user_id: params[:token])
    render json: tasks
  end

  def get_a_task
    task = Task.find(params[:id])

    if task
      render json: tag
    else
      render json: {error: "Tarefa não encontrada!"}
    end
  end

  def create
    new_task = Task.new(
      description: params[:description],
      user_id: params[:user_id],
      state: params[:state],
      task_type: params[:task_type],
      url_for_scraping: params[:url_for_scraping],
    )

    if new_task.save
      render json: new_task
    else
      render json: {error: "Erro ao criar tarefa!"}
    end
  end

  def edit
    task = Task.find(params[:id])

    unless task
      render json: {error: "Tarefa não encontrada!"}
      return
    end

    task.update(
      description: params[:description],
      user_id: params[:user_id],
      state: params[:state],
      type: params[:type],
      url_for_scraping: params[:url_for_scraping],
    )
  end

  def delete
    task = Task.find(params[:task_id])

    unless task
      render json: {error: "Tarefa não encontrada!"}
      return
    end

    task.destroy
  end
end
