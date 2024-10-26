class AddDepartmentIdToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :department_id, :integer
  end
end
