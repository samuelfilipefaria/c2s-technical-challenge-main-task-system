require 'rails_helper'

RSpec.describe DeleteUserTaskService do
  describe ".perform" do
    context "valid id" do
      it "deletes a user task" do
        user_task = get_test_user_task
        expect { described_class.new(user_task.id).perform }.to change { UserTask.count }.by(-1)
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
        expect { described_class.new(user_task.id * -1).perform }.to raise_error
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
