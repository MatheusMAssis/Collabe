class HomeController < ApplicationController
  def index
    @featured_events = Event.includes(:user, :attendees)
                          .where("date >= ?", Date.current)
                          .order(:date)
                          .limit(6)
  end
end
