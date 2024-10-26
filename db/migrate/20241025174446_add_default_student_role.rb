class AddDefaultStudentRole < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :role, :student
  end
end
