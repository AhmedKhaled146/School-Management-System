class CreateStudents < ActiveRecord::Migration[7.2]
  def change
    create_table :students do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.integer :age
      t.string :phone

      t.timestamps
    end
  end
end
