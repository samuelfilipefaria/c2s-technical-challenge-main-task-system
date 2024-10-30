require 'rails_helper'

RSpec.describe UpdateWebScrapingTaskService do
  describe ".perform" do
    context "passing only state" do
      it "updates the web scraping task state and keeps the other parameters" do
        web_scraping_task = get_test_web_scraping_task

        subject = described_class.new(
          web_scraping_task.id,
          "em progresso",
        )

        subject.perform
        web_scraping_task.reload
        
        expect(web_scraping_task.url_for_scraping).to eq(web_scraping_task.url_for_scraping)
        expect(web_scraping_task.state).to eq("em progresso")
        expect(web_scraping_task.creator_id).to eq(1)
      end
    end

    context "null state" do
      it "keeps state" do
        web_scraping_task = get_test_web_scraping_task

        subject = described_class.new(
          web_scraping_task.id,
          nil,
        )

        subject.perform
        web_scraping_task.reload
        
        expect(web_scraping_task.url_for_scraping).to eq(web_scraping_task.url_for_scraping)
        expect(web_scraping_task.state).to eq(web_scraping_task.state)
        expect(web_scraping_task.creator_id).to eq(1)
      end
    end

    context "empty state" do
      it "raises an error" do
        web_scraping_task = get_test_web_scraping_task

        subject = described_class.new(
          web_scraping_task.id,
          ""
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null id" do
      it "raises an error" do
        web_scraping_task = get_test_web_scraping_task

        subject = described_class.new(
          nil,
          "Outra task"
        )

        expect { subject.perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        web_scraping_task = get_test_web_scraping_task

        subject = described_class.new(
          web_scraping_task.id * -1,
          "Outra task"
        )

        expect { subject.perform }.to raise_error
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
