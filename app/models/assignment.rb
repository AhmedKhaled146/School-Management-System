class Assignment < ApplicationRecord
  # Relations
  belongs_to :course

  # Validates
  validates :title, uniqueness: true, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 10..500 }
  validates :course_id, presence: true
end
