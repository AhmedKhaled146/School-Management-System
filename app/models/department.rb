class Department < ApplicationRecord
  # Relations
  belongs_to :manager, class_name: 'User'
  has_many :instructors, -> { where(role: 'instructor') }, class_name: 'User', foreign_key: :department_id
  has_many :students, -> { where(role: 'student') }, class_name: 'User', foreign_key: :department_id
  has_many :courses

  # Validates
  validates :name, presence: true, uniqueness: true
  validate :manager_must_be_instructor

  private

  def manager_must_be_instructor
    errors.add(:manager, "must be an instructor") if manager && !manager.instructor?
  end
end
