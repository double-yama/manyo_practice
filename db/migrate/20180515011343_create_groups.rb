class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string  :name, null: false, unique: true
      t.string  :description
      t.timestamps
    end
  end
end
