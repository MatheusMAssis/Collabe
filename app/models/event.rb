class Event < ApplicationRecord
  belongs_to :user
  has_many :registrations, dependent: :destroy
  has_many :attendees, through: :registrations, source: :user
  has_many :comments, dependent: :destroy

  # Categories for events
  CATEGORIES = [
    "Workshop",
    "Study Group",
    "Conference",
    "Meetup",
    "Seminar",
    "Networking",
    "Other"
  ].freeze

  validates :category, inclusion: { in: CATEGORIES }
  validates :title, presence: true
  validates :description, presence: true
  validates :date, presence: true

  # Scopes for filtering
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :by_date_range, ->(start_date, end_date) {
    where(date: start_date..end_date) if start_date.present? && end_date.present?
  }
  scope :search_by_title_and_description, ->(query) {
    where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") if query.present?
  }

  # Get count of attendees
  def attendee_count
    attendees.count
  end
end
