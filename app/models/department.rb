class Department < ApplicationRecord
  # Relations
  belongs_to :manager, class_name: 'User'
  has_many :instructors, -> { where(role: 'instructor') }, class_name: 'User', foreign_key: :department_id
  has_many :students, -> { where(role: 'student') }, class_name: 'User', foreign_key: :department_id
  has_many :courses

  # Validates
  validates :name, presence: true, uniqueness: true
end
