class AddReferencesToStudent < ActiveRecord::Migration[7.2]
  def change
    add_reference :students, :department, null: false, foreign_key: true
  end
end
