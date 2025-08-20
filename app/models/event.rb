class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy
  has_many :attendees, through: :registrations, source: :user
  has_many :comments, dependent: :destroy

  # Get count of attendees
  def attendee_count
    attendees.count
  end
end
