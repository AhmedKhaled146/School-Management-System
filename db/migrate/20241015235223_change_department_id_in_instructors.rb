class ChangeDepartmentIdInInstructors < ActiveRecord::Migration[7.2]
  def change
    change_column_null :instructors, :department_id, true
  end
end
