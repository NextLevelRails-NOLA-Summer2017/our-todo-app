class Task < ApplicationRecord
  belongs_to :user

  validates :name, :priority, :due_date, presence: true
end
