class AddColumnToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :read_flg, :boolean, default: false
  end
end
