require 'rails_helper'

RSpec.describe GetWebScrapingTaskDataService do
  describe ".perform" do
    context "valid id" do
      it "returns the web scraping task" do
        web_scraping_task = get_test_web_scraping_task
        expect(described_class.new(web_scraping_task.id).perform).to eq(web_scraping_task)
      end
    end

    context "null id" do
      it "raises an error" do
        expect { described_class.new(nil).perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        web_scraping_task = get_test_web_scraping_task
        expect { described_class.new(user.id * -1).perform }.to raise_error
      end
    end

    def get_test_web_scraping_task
      WebScrapingTask.create(
        url_for_scraping: "https://google.com",
        state: "pendente",
        creator_id: 1
      )

      web_scraping_task = WebScrapingTask.last

      web_scraping_task
    end
  end
end
