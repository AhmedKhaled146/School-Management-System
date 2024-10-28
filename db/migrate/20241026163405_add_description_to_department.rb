class AddDescriptionToDepartment < ActiveRecord::Migration[7.2]
  def change
    add_column :departments, :description, :text
  end
end
