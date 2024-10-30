require 'rails_helper'

RSpec.describe UpdateUserTaskService do
  describe ".perform" do
    context "all valid parameters" do
      it "updates all user task parameters" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          "Outra task",
          "em progresso",
        )

        subject.perform
        user_task.reload
        
        expect(user_task.description).to eq("Outra task")
        expect(user_task.state).to eq("em progresso")
        expect(user_task.creator_id).to eq(1)
      end
    end

    context "passing only description" do
      it "updates the user task description and keeps the state" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          "Outra task",
        )

        subject.perform
        user_task.reload
        
        expect(user_task.description).to eq("Outra task")
        expect(user_task.state).to eq("pendente")
        expect(user_task.creator_id).to eq(1)
      end
    end

    context "passing only state" do
      it "updates the user state and keeps the description" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          nil,
          "em progresso"
        )

        subject.perform
        user_task.reload
        
        expect(user_task.description).to eq("Minha task")
        expect(user_task.state).to eq("em progresso")
        expect(user_task.creator_id).to eq(1)
      end
    end

    context "empty description" do
      it "raises an error" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          "",
          "em progresso"
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "repeated description" do
      it "raises an error" do
        user_task = get_test_user_task

        UserTask.create(
          description: "Outra task",
          state: "pendente",
          creator_id: 1
        )

        subject = described_class.new(
          user_task.id,
          "Outra task",
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty state" do
      it "raises an error" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          "Outra task",
          ""
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null id" do
      it "raises an error" do
        user_task = get_test_user_task

        subject = described_class.new(
          nil,
          "Outra task",
          "em progresso"
        )

        expect { subject.perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id * -1,
          "Outra task",
          "em progresso"
        )

        expect { subject.perform }.to raise_error
      end
    end

    context "all null parameters" do
      it "keeps all parameters" do
        user_task = get_test_user_task

        subject = described_class.new(
          user_task.id,
          nil,
          nil
        )

        subject.perform
        user_task.reload
        
        expect(user_task.description).to eq(user_task.description)
        expect(user_task.state).to eq(user_task.state)
        expect(user_task.creator_id).to eq(user_task.creator_id)
      end
    end

    def get_test_user_task
      UserTask.create(
        description: "Minha task",
        state: "pendente",
        creator_id: 1
      )

      user_task = UserTask.last

      user_task
    end
  end
end
