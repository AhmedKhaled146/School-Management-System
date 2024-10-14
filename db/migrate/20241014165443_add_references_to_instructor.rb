class AddReferencesToInstructor < ActiveRecord::Migration[7.2]
  def change
    add_reference :instructors, :department, null: false, foreign_key: true
  end
end
