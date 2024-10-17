class Department < ApplicationRecord
  belongs_to :manager, class_name: 'Instructor', optional: true
  has_many :students
  has_many :instructors
  has_many :managed_departments, class_name: 'Department', foreign_key: 'manager_id' # For see what department manage by instructor

  validates :name, presence: true, uniqueness: true
end
