class Enrollment < ApplicationRecord
  # Relations
  belongs_to :course
  belongs_to :user

  # Validates
  validate :user_is_student

  private

  def user_is_student
    errors.add(:user, "Must Be Student") unless user&.student?
  end
end
