class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :Description
      t.references :instructor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
