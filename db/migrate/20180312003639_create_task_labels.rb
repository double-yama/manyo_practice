class CreateTaskLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :task_labels do |t|
      t.integer :task_id,  index: true, foreign_key: true
      t.integer :label_id,  index: true, foreign_key: true
      # t.references :task,  index: true, foreign_key: true
      # t.references :label,  index: true, foreign_key: true
      t.timestamps
    end
  end
end