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
  price: 6300000,
  rooms: 3,
  bathrooms: 1,
  address: "1690-4 Imaichichō, Izumo, Shimane 693-0001",
  fake_latitude: 35.3614928,
  fake_longitude: 132.7588458
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "Small house in Tenjincho",
  price: 5500000,
  rooms: 2,
  bathrooms: 1,
  address: "Tenjincho, Izumo, Shimane 693-0005",
  fake_latitude: 35.3650468,
  fake_longitude: 132.7420556
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "Big house in Yanocho district",
  price: 5850000,
  rooms: 4,
  bathrooms: 2,
  address: "Yanocho, Izumo, Shimane 693-0058",
  fake_latitude: 35.37891,
  fake_longitude: 132.737748
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "House nearby the mountains",
  price: 6100000,
  rooms: 2,
  bathrooms: 1,
  address: "Hiranocho, Izumo, Shimane 693-0065",
  fake_latitude: 35.39185,
  fake_longitude: 132.742554
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "Big house by the sea",
  price: 8900000,
  rooms: 4,
  bathrooms: 2,
  address: "Taishacho Kizukinishi, Izumo, Shimane 699-0751",
  fake_latitude: 35.382282,
  fake_longitude: 132.674817
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "House close to the sea and mountains",
  price: 9200000,
  rooms: 2,
  bathrooms: 1,
  address: "Shimane, Izumo, Taishacho Nakaaraki",
  fake_latitude: 35.379698,
  fake_longitude: 132.692814
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "House right near Hinomisakiinari Shrine",
  price: 7100000,
  rooms: 2,
  bathrooms: 1,
  address: "447 Koryocho Sanbu, Izumo, Shimane",
  fake_latitude: 35.308655,
  fake_longitude: 132.683462
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "House on the shore of Jinzai Lake",
  price: 6850000,
  rooms: 2,
  bathrooms: 2,
  address: "2577-12 Jinzaiokicho, Izumo, Shimane",
  fake_latitude: 35.3341155,
  fake_longitude: 132.6967187
  # account_id: Account.first.id
}])
# Property.last.save
Property.create([{
  title: "House nearby Kanda river",
  price: 5780000,
  rooms: 2,
  bathrooms: 2,
  address: "157 Koshicho, Izumo, Shimane",
  fake_latitude: 35.32898,
  fake_longitude: 132.749879
  # account_id: Account.first.id
}])

Property.create([{
  title: "House nearby Masakigaoka park",
  price: 5500000,
  rooms: 3,
  bathrooms: 1,
  address: "1175-1 Kandocho, Izumo, Shimane",
  fake_latitude: 35.33939,
  fake_longitude: 132.71363
  # account_id: Account.first.id
}])

Property.create([{
  title: "Izumo Taisha beautiful house",
  price: 10500000,
  rooms: 4,
  bathrooms: 2,
  address: "699-0701 Shimane, Izumo, Taishacho Kizukihigashi",
  fake_latitude: 35.4032228,
  fake_longitude: 132.6833164
  # account_id: Account.first.id
}])

p "Created #{Property.count} Properties"

# Rating.destroy_all
# Rating.create!([{
#   property_id: Property.first.id,
#   location_rating: 8.0
# }])
# Rating.first.save
# p "Created #{Rating.count} Ratings"

