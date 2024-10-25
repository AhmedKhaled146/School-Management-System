class User < ApplicationRecord
  # Include Devise Settings
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  # Relations
  has_many :courses, foreign_key: 'instructor_id'
  belongs_to :department, optional: true
  has_many :managed_departments, class_name: 'Department', foreign_key: :manager_id

  # Set Roles for Users
  enum role: { admin: "admin", student: "student", instructor: "instructor" }

  # Validates
  validates :email, uniqueness: true , presence: true
  validates :first_name, :last_name, presence: true
  validates :password, presence: true, length: { minimum: 6 }

end