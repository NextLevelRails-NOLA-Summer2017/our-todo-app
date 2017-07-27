class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :firstname, :lastname

  has_many :tasks

  def full_name
    "#{self.firstname} #{self.lastname}"
  end

  def due_today
    self.tasks.select { |t| t.due_date.to_date == DateTime.now.utc.to_date }

  end
end
