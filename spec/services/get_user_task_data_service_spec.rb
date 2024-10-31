require 'rails_helper'

RSpec.describe GetUserTaskDataService do
  describe ".perform" do
    context "valid id" do
      it "returns the user task" do
        user_task = get_test_user_task
        expect(described_class.new(user_task.id).perform).to eq(user_task)
      end
    end

    context "null id" do
      it "raises an error" do
        expect { described_class.new(nil).perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        user_task = get_test_user_task
        expect { described_class.new(user.id * -1).perform }.to raise_error
      end
    end

    def get_test_user_task
      UserTask.create(
        description: "Minha task",
        state: "pending",
        creator_id: 1
      )

      user_task = UserTask.last

      user_task
    end
  end
end
