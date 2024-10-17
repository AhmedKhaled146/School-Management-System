class CreateInstructors < ActiveRecord::Migration[7.2]
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.integer :salary
      t.string :phone

      t.timestamps
    end
  end
end
