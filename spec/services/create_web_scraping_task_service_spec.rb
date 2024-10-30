require 'rails_helper'

RSpec.describe CreateWebScrapingTaskService do
  subject {
    described_class.new(
      "https://google.com",
      "pendente",
      1
    )
  }

  describe ".perform" do
    context "all valid parameters" do
      it "creates the web scraping task" do
        expect { subject.perform }.to change { WebScrapingTask.count }.by(1)
      end
    end

    context "null url for scraping" do
      it "raises an error" do
        subject.url_for_scraping = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty url for scraping" do
      it "raises an error" do
        subject.url_for_scraping = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "repeated url for scraping" do
      it "raises an error" do
        WebScrapingTask.create(
          url_for_scraping: "https://google.com",
          state: "pendente",
          creator_id: 1
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null state" do
      it "raises an error" do
        subject.state = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty state" do
      it "raises an error" do
        subject.state = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null creator id" do
      it "raises an error" do
        subject.creator_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "negative creator id" do
      it "raises an error" do
        subject.creator_id = subject.creator_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all null parameters" do
      it "raises an error" do
        subject.url_for_scraping = nil
        subject.state = nil
        subject.creator_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all empty or negative parameters" do
      it "raises an error" do
        subject.url_for_scraping = ""
        subject.state = ""
        subject.creator_id = subject.creator_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end
  end
end
