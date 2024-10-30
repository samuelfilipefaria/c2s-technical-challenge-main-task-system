class UpdateWebScrapingTaskService
  attr_accessor :id, :new_state

  def initialize(id, new_state = nil)
    @id = id
    @new_state = new_state
  end

  def perform
    web_scraping_task = WebScrapingTask.find(id)

    raise ArgumentError.new("Invalid user id!") unless web_scraping_task
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    web_scraping_task.update(
      state: new_state || web_scraping_task.state
    )
  end

  private

  def valid_parameters?
    valid_new_state?
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
