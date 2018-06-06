class ChangeDatatypePriorityOfTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :priority, :integer
  end
end
