# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Account.destroy_all
Account.create!([{
  first_name: "Tanaka",
  last_name: "Izumoshi",
  email: "tanaka@izumo.com"
}])
Account.first.save
p "Created #{Account.count} Accounts"


Property.destroy_all
Property.create!([{
  title: "Izumo House",
  price: 20000,
  rooms: 2,
  bathrooms: 1,
  address: "1690-4 Imaichichō, Izumo, Shimane 693-0001",
  account_id: Account.first.id
}])
Property.first.save
p "Created #{Property.count} Properties"

Rating.destroy_all
Rating.create!([{
  property_id: Property.first.id,
  location_rating: 8.0
}])
Rating.first.save
p "Created #{Rating.count} Ratings"

