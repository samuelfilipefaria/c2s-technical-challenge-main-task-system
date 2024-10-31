class CreateUserTaskService
  attr_accessor :description, :state, :creator_id

  def initialize(description, state, creator_id)
    @description = description
    @state = state
    @creator_id = creator_id
  end

  def perform
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    UserTask.create(
      description: description,
      state: state,
      creator_id: creator_id
    )

    UserTask.last.id
  end

  private

  def valid_parameters?
    valid_description? && valid_state? && valid_creator_id?
  end

  def valid_description?
    raise ArgumentError.new("Invalid user task description!") unless valid_non_empty_string_parameter?(description, "description")

    other_user_task_with_the_same_description = UserTask.find_by(description: description)
    raise ArgumentError.new("Invalid user task description! Other task already has this description!") if other_user_task_with_the_same_description

    true 
  end

  def valid_state?
    valid_non_empty_string_parameter?(state, "state")
  end

  def valid_creator_id?
    valid_non_negative_number_parameter?(creator_id, "creator id")
  end

  def valid_non_empty_string_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    parameter.strip!
    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.empty?

    true
  end

  def valid_non_negative_number_parameter?(parameter, parameter_name)
    raise ArgumentError.new("Invalid #{parameter_name}!") unless parameter

    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter.to_i < 0

    true
  end
end
