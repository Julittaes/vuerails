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
p "Created #{Account.count} Accounts"


Property.destroy_all
Property.create!([{
  title: "Izumo House",
  price: 20000,
  rooms: 2,
  bathrooms: 1,
  photo: nil,
  avg_rating: 8,
  account_id: Account.first.id
}])
p "Created #{Property.count} Properties"

Location.destroy_all
Location.create!([{
  name: "Tanaka-san house",
  address: "1690-4 Imaichichō, Izumo, Shimane 693-0001",
  property_id: Property.first.id
}])
p "Created #{Location.count} Locations"
