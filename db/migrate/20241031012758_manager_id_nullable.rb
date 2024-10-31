class ManagerIdNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :departments, :manager_id, true
  end
end
