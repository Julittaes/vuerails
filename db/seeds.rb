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
  title: "House in Imaichicho",
  price: 2000000,
  rooms: 3,
  bathrooms: 1,
  address: "1690-4 Imaichichō, Izumo, Shimane 693-0001",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "New house in Tenjincho",
  price: 2500000,
  rooms: 2,
  bathrooms: 1,
  address: "Tenjincho, Izumo, Shimane 693-0005",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "Beautiful house inn Yanocho district",
  price: 3000000,
  rooms: 4,
  bathrooms: 2,
  address: "Yanocho, Izumo, Shimane 693-0058",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "House nearby the mountains",
  price: 2750000,
  rooms: 2,
  bathrooms: 1,
  address: "Hiranocho, Izumo, Shimane 693-0065",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "New house by the sea",
  price: 4700000,
  rooms: 4,
  bathrooms: 2,
  address: "Taishacho Kizukinishi, Izumo, Shimane 699-0751",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "House close to the sea annd mountains",
  price: 3200000,
  rooms: 2,
  bathrooms: 1,
  address: "Shimane, Izumo, Taishacho Nakaaraki",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "House right near Hinomisakiinari Shrine",
  price: 2400000,
  rooms: 2,
  bathrooms: 1,
  address: "447 Koryocho Sanbu, Izumo, Shimane",
  account_id: Account.first.id
}])
Property.last.save
Property.create!([{
  title: "House on the shore of Jinzai Lake",
  price: 2230000,
  rooms: 2,
  bathrooms: 2,
  address: "2577-12 Jinzaiokicho, Izumo, Shimane",
  account_id: Account.first.id
}])
Property.last.save
p "Created #{Property.count} Properties"

Rating.destroy_all
Rating.create!([{
  property_id: Property.first.id,
  location_rating: 8.0
}])
Rating.first.save
p "Created #{Rating.count} Ratings"

