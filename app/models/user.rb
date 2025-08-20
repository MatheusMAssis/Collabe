class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :registered_events, through: :registrations, source: :event
  has_many :comments, dependent: :destroy

  # Active Storage attachments
  has_one_attached :profile_picture

  # Callbacks
  after_create :send_welcome_email

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

  # Check if user is registered for an event
  def registered_for?(event)
    registered_events.include?(event)
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end
end
