require 'rails_helper'

RSpec.describe Task, :type => :model do
  subject {
    described_class.new(
      description: "Task",
      user_id: "123",
      task_type: "web scraping",
      state: "pendente",
    )
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a user_id" do
    subject.user_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a task_type" do
    subject.task_type = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a state" do
    subject.state = nil
    expect(subject).to_not be_valid
  end
end
