class CreateWebScrapingTaskService
  attr_accessor :url_for_scraping, :state, :creator_id

  def initialize(url_for_scraping, state, creator_id)
    @url_for_scraping = url_for_scraping
    @state = state
    @creator_id = creator_id
  end

  def perform
    raise ArgumentError.new("Invalid arguments!") unless valid_parameters?

    WebScrapingTask.create(
      url_for_scraping: url_for_scraping,
      state: state,
      creator_id: creator_id
    )

    WebScrapingTask.last.id
  end

  private

  def valid_parameters?
    valid_url_for_scraping? && valid_state? && valid_creator_id?
  end

  def valid_url_for_scraping?
    raise ArgumentError.new("Invalid URL for scraping!") unless valid_non_empty_string_parameter?(url_for_scraping, "url_for_scraping")

    other_web_scraping_task_with_the_same_url = WebScrapingTask.find_by(url_for_scraping: url_for_scraping)
    raise ArgumentError.new("Invalid URL for scraping! Other task already has this URL!") if other_web_scraping_task_with_the_same_url

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

    raise ArgumentError.new("Invalid #{parameter_name}!") if parameter < 0

    true
  end
end