class AddManagerIdToDepartment < ActiveRecord::Migration[7.2]
  def change
    add_column :departments, :manager_id, :integer, null: false

    add_foreign_key :departments, :users, column: :manager_id
  end
end
