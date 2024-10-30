class UpdateUserTaskService
  attr_accessor :id, :new_description, :new_state

  def initialize(id, new_description = nil, new_state = nil)
    @id = id
    @new_description = new_description
    @new_state = new_state
  end

  def perform
    user_task = UserTask.find(id)

    raise ArgumentError.new("Invalid user id!") unless user_task
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    user_task.update(
      description: new_description || user_task.description,
      state: new_state || user_task.state,
    )
  end

  private

  def valid_parameters?
    valid_new_description? && valid_new_state?
  end

  def valid_new_description?
    raise ArgumentError.new("Invalid user task description!") unless valid_non_empty_string_parameter?(new_description, "new description")

    other_user_task_with_the_same_description = UserTask.find_by(description: new_description)
    raise ArgumentError.new("Invalid user task description! Other task already has this description!") if other_user_task_with_the_same_description && other_user_task_with_the_same_description.id != id

    true 
  end

  def valid_new_state?
    valid_non_empty_string_parameter?(new_state, "new state")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    return true unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end
end
