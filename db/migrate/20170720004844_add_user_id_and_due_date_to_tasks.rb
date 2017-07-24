class AddUserIdAndDueDateToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :due_date, :datetime
    add_reference :tasks, :user, foreign_key: true
  end
end
