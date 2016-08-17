#encode: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create([
  {color: "red", rgb: "#FF6600", code: 1 },
  {color: "yellow", rgb: "#FFCC00", code: 2 },
  {color: "blue", rgb: "#000044", code: 3 },
  {color: "green", rgb: "#0E6C20", code: 4 },
  {color: "black", rgb: "#333", code: 5 }
])

Season.create(number: Time.now.year)
