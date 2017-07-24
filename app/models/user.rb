class User < ApplicationRecord
  has_many :tasks

  validates_presence_of :firstname, :lastname
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def due_today
    self.tasks.select { |task| task.due_date.to_date == DateTime.now.utc.to_date }
  end

end
