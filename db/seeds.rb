# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.first_or_create(name: "ManuMatch Admin",
  id: 1,
  company_name: "manu_match company",
  email: "manu_match@example.com",
  password:              "manumatch",
  password_confirmation: "manumatch",
  administrator: true
)

user1 = User.first_or_create(name: "test user",
  id: 2,
  company_name: "test company",
  email: "test@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
)
