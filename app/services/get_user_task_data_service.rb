class GetUserTaskDataService
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def perform
    user_task = UserTask.find(id)

    raise ArgumentError.new("Invalid user task id!") unless user_task

    user_task
  end
end
