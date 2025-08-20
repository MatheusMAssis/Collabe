class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy

  # Role management
  ROLES = %w[user admin].freeze

  validates :role, inclusion: { in: ROLES }

  # Role helper methods
  def admin?
    role == "admin"
  end

  def user?
    role == "user"
  end
end
