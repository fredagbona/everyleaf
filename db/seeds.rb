# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(
    name: "John",
    email: "john@gmail.com",
    password: "john2021"
)

5.times do 
    Task.create(
        name: "Name1",
        description: "Description1",
        expiration_date: DateTime.now,
        status: 0,
        priority: 2
    )
end