class UserTask < ApplicationRecord
  validates_presence_of :description, :state, :creator_id
  validates :description, uniqueness: true
end
