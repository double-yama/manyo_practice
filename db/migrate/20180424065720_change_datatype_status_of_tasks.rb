class ChangeDatatypeStatusOfTasks < ActiveRecord::Migration[5.1]
  def change
    change_column :tasks, :status, :int
  end
end
