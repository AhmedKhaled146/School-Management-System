class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :rememberable, :recoverable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, uniqueness: { case_sensitive: true }, presence: true
  validates :first_name, :last_name, presence: true
end
