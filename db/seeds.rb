# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"

puts "Cleaning database..."
Restaurant.destroy_all
Review.destroy_all

puts "Creating restaurants..."
7.times do
  category = %w(chinese italian japanese french belgian)
  restaurant = Restaurant.new(
    name: Faker::Restaurant.name ,
    address: Faker::Address.city,
    phone_number: Faker::PhoneNumber.cell_phone ,
    category: category.sample
  )
  puts "Created #{restaurant.name}"
  restaurant.save!
  3.times do
    rating = [0, 1, 2, 3, 4, 5]
    review = Review.new(
      content: Faker::Lorem.paragraph,
      rating: rating.sample,
      restaurant_id: restaurant.id
    )
    puts "Created review"
    review.save!
  end
end
puts "Finished!"
