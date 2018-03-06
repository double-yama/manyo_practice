class AddPeriodToTask < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :period, :date
  end
end
