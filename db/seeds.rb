# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user_admin = User.find_or_initialize_by_email(:email => "admin@example.com")
user_admin.assign_attributes(
  :password => "password"
)
user_admin.save!

user_admin.user_roles.create!(:role => "administrator")
