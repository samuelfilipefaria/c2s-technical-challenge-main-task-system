require 'rails_helper'

RSpec.describe WebScrapingTask, type: :model do
  subject {
    described_class.new(
      url_for_scraping: "https://google.com",
      state: "pendente",
      creator_id: 1
    )
  }

  context "all valid parameters" do
    it "is a valid web scraping task" do
      expect(subject).to be_valid
    end
  end

  context "null url for scraping" do
    it "is not a valid web scraping task" do
      subject.url_for_scraping = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty url for scraping" do
    it "is not a valid web scraping task" do
      subject.url_for_scraping = ""
      expect(subject).to_not be_valid
    end
  end

  context "null state" do
    it "is not a valid web scraping task" do
      subject.state = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty state" do
    it "is not a valid web scraping task" do
      subject.state = ""
      expect(subject).to_not be_valid
    end
  end

  context "null creator id" do
    it "is not a valid web scraping task" do
      subject.creator_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty creator id" do
    it "is not a valid web scraping task" do
      subject.creator_id = ""
      expect(subject).to_not be_valid
    end
  end
end
