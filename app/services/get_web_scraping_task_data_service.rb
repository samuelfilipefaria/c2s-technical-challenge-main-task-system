class GetWebScrapingTaskDataService
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def perform
    web_scraping_task = WebScrapingTask.find(id)

    raise ArgumentError.new("Invalid web scraping task id!") unless web_scraping_task

    web_scraping_task
  end
end
