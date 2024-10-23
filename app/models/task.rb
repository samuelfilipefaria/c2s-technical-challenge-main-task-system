class Task < ApplicationRecord
  validates_presence_of :description, :user_id, :task_type, :state
end
