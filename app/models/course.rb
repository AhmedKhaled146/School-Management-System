class Course < ApplicationRecord
  # Relations
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  belongs_to :department
  has_many :assignments, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user # Easy access to the students enrolled in each course.

  # Validates
  validates :name, :department_id, :instructor_id, presence: true
end
