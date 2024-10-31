class Department < ApplicationRecord
  # Relations
  belongs_to :manager, class_name: 'User', optional: true
  has_many :instructors, -> { where(role: 'instructor') }, class_name: 'User', foreign_key: :department_id
  has_many :students, -> { where(role: 'student') }, class_name: 'User', foreign_key: :department_id
  has_many :courses

  # Validates
  validates :name, presence: true, uniqueness: true
  validate :manager_must_be_instructor_and_in_this_department

  private

  def manager_must_be_instructor_and_in_this_department
    if manager
      unless manager.instructor? && manager.department_id == id
        errors.add(:manager, "must be an instructor within this department")
      end
    end
  end
end
