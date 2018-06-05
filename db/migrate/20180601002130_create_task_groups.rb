class CreateTaskGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :task_groups do |t|
      t.integer :task_id, foreign_key: true
      t.integer :group_id, foreign_key: true

      t.timestamps
    end
  end
end
