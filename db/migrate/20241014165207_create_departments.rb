class CreateDepartments < ActiveRecord::Migration[7.2]
  def change
    create_table :departments do |t|
      t.string :name
      t.date :hire_date

      t.timestamps
    end
  end
end
