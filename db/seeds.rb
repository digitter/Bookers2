# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do |i|
  u = User.new(name: "user#{i}", introduction: "introduction#{i}", email: "#{i}@#{i}.#[i}", password: "#{i}" * 6, password_confirmation: "#{i}" * 6)
  u.save!
  Book.create!(user_id: u.id, title: "#{i}", body: "body body body")
end

