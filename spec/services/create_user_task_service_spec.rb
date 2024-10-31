require 'rails_helper'

RSpec.describe CreateUserTaskService do
  subject {
    described_class.new(
      "Minha task",
      "pending",
      1
    )
  }

  describe ".perform" do
    context "all valid parameters" do
      it "creates the user task" do
        expect { subject.perform }.to change { UserTask.count }.by(1)
      end
    end

    context "null description" do
      it "raises an error" do
        subject.description = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty description" do
      it "raises an error" do
        subject.description = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "repeated description" do
      it "raises an error" do
        UserTask.create(
          description: "Minha task",
          state: "pending",
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
        subject.description = nil
        subject.state = nil
        subject.creator_id = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all empty or negative parameters" do
      it "raises an error" do
        subject.description = ""
        subject.state = ""
        subject.creator_id = subject.creator_id * -1
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end
  end
end
