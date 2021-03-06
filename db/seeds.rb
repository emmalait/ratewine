# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = 400             # jos koneesi on hidas, riittää esim 200
wineries = 200         # jos koneesi on hidas, riittää esim 100
wines_in_winery = 50
ratings_per_user = 30

(1..users).each do |i|
  User.create! username: "user_#{i}", password:"Passwd1", password_confirmation: "Passwd1"
end

(1..wineries).each do |i|
  Winery.create! name:"Winery_#{i}", year: 1900, active: true
end

bulk = Style.create! name: "Bulk", description: "cheap, not much taste"

Winery.all.each do |b|
  n = rand(wines_in_winery)
  (1..n).each do |i|
    wine = Wine.create! name:"Wine #{b.id} -- #{i}", style:bulk, winery:b
    b.wines << wine
  end
end

User.all.each do |u|
  n = rand(ratings_per_user)
  wines = Wine.all.shuffle
  (1..n).each do |i|
    r = Rating.new score:(1+rand(50))
    wines[i].ratings << r
    u.ratings << r
  end
end