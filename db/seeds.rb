# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.find_by_type_role('admin')

unless user.present?
  user_new = User.create(email: "fd@mail.ru", type_role: "admin", password: "Kzn2021$")
  user_new.build_profile(full_name: 'Администратор', mobile: '+79272000000')
  user_new.save
end