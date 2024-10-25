class Course < ApplicationRecord
  belongs_to :instructor, class_name: 'User', foreign_key: 'instructor_id'
  belongs_to :department

  validates :name, :department_id, presence: true
end
