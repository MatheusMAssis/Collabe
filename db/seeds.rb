# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create sample users if they don't exist
admin_user = User.find_or_create_by(email: "admin@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Admin User"
  user.bio = "System administrator"
  user.role = "admin"
end

regular_user = User.find_or_create_by(email: "user@example.com") do |user|
  user.password = "password"
  user.password_confirmation = "password"
  user.name = "Regular User"
  user.bio = "Event enthusiast"
  user.role = "user"
end

# Create sample events with different categories
sample_events = [
  {
    title: "Ruby on Rails Workshop",
    description: "Learn the fundamentals of Ruby on Rails web development",
    category: "Workshop",
    date: 1.week.from_now,
    user: admin_user
  },
  {
    title: "JavaScript Study Group",
    description: "Weekly study group for JavaScript developers",
    category: "Study Group",
    date: 2.weeks.from_now,
    user: admin_user
  },
  {
    title: "Tech Conference 2025",
    description: "Annual technology conference featuring industry leaders",
    category: "Conference",
    date: 1.month.from_now,
    user: regular_user
  },
  {
    title: "Local Developers Meetup",
    description: "Networking event for local software developers",
    category: "Meetup",
    date: 3.days.from_now,
    user: regular_user
  },
  {
    title: "Database Design Seminar",
    description: "Advanced seminar on database design principles",
    category: "Seminar",
    date: 2.months.from_now,
    user: admin_user
  },
  {
    title: "Startup Networking Event",
    description: "Network with entrepreneurs and startup founders",
    category: "Networking",
    date: 10.days.from_now,
    user: regular_user
  }
]

sample_events.each do |event_attrs|
  Event.find_or_create_by(
    title: event_attrs[:title],
    user: event_attrs[:user]
  ) do |event|
    event.description = event_attrs[:description]
    event.category = event_attrs[:category]
    event.date = event_attrs[:date]
  end
end

puts "Created #{User.count} users and #{Event.count} events"
