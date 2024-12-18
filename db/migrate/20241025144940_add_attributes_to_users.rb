class AddAttributesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :age, :integer
    add_column :users, :role, :string
    add_column :users, :salary, :decimal
  end
end
