require 'rails_helper'

RSpec.describe UserTask, type: :model do
  subject {
    described_class.new(
      description: "https://google.com",
      state: "pending",
      creator_id: 1
    )
  }

  context "all valid parameters" do
    it "is a valid user task" do
      expect(subject).to be_valid
    end
  end

  context "null description" do
    it "is not a valid user task" do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty description" do
    it "is not a valid user task" do
      subject.description = ""
      expect(subject).to_not be_valid
    end
  end

  context "null state" do
    it "is not a valid user task" do
      subject.state = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty state" do
    it "is not a valid user task" do
      subject.state = ""
      expect(subject).to_not be_valid
    end
  end

  context "null creator id" do
    it "is not a valid user task" do
      subject.creator_id = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty creator id" do
    it "is not a valid user task" do
      subject.creator_id = ""
      expect(subject).to_not be_valid
    end
  end
end
