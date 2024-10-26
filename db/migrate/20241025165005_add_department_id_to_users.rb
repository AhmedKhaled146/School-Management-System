class AddDepartmentIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :department_id, :integer
  end
end
