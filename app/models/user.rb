class User < ApplicationRecord
  has_one :student, dependent: :destroy
  has_one :instructor, dependent: :destroy

  before_create :set_default_role
  after_create :create_associated_role

  enum role: { admin: "admin", student: "student", instructor: "instructor" }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  private

  def set_default_role
    self.role ||= :student
  end

  def create_associated_role
    if student?
      create_student
    elsif instructor?
      create_instructor
    end
  end

end
