class User < ApplicationRecord
  has_one :student
  has_one :instructor

  before_create  :set_default_role
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

end
