# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "\n== Seeding the database with fixtures =="
system('bin/rails db:fixtures:load')

# puts "\n== Seeding Users =="

# 50.times do
#   User.create(username: Faker::Internet.unique.username, email: Faker::Internet.email,
#               password: Devise::Encryptor.digest(User, 'password'), bio: Faker::Quotes::Shakespeare.hamlet_quote).save!
# end

# u = User.first

# puts "\n== Seeding Articles =="

# User.all.each do |u|
#   u.articles.build(body: Faker::Quote.famous_last_words).save
#   u.articles.build(body: Faker::Quote.jack_handey).save
#   u.articles.build(body: Faker::Quote.matz).save
#   u.articles.build(body: Faker::Quote.most_interesting_man_in_the_world).save
#   u.articles.build(body: Faker::Quote.yoda).save
# end

# puts "\n== Seeding Friends requests =="

# User.all.each do |user|
#   user.requested_friends.build(receiver_id: u.id).save unless user == u
# end
