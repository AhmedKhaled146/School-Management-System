class User < ApplicationRecord

  before_create  :set_default_role
  enum role: { admin: "admin", student: "student", instructor: "instructor" }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  private

  def set_default_role
    self.role ||= :student
  end

end
