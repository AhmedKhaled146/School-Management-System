class AddInstructoridNullableToCourse < ActiveRecord::Migration[7.2]
  def change
    change_column_null :courses, :instructor_id, true
  end
end
