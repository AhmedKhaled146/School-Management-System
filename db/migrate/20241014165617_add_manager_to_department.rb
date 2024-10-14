class AddManagerToDepartment < ActiveRecord::Migration[7.2]
  def change
    add_reference :departments, :manager, null: false, foreign_key: { to_table: :instructors }
  end
end
