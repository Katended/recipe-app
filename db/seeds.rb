# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
begin
User.create(
  name: "John Doe",
  email: "2@ffs.d",
  password: "password"
)

Recipe.create(
    name: "My Recipe",
    preparation_time: "1 hour",
    cooking_time: "1 hour",
    public: true,
    description: "My Description",
    user_id: 1
  )

  Food.create(
    name: "My Food",
    measurement_unit: "kg",
    price: 1.99
  )

  RecipeFood.create(
    quantity: '3',
    recipe_id: 1,
    food_id: 1
  )


  20.times do
    User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "password"
    )
  end
  
  prng = Random.new

  20.times do
    Recipe.create(
      name: Faker::Name.name,
      preparation_time: "#{Faker::Number.number(digits: 2)} hours",
      cooking_time: "#{Faker::Number.number(digits: 2)} hours",
      public: Faker::Boolean.boolean,
      description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false),
      user_id: prng.rand(1..20)
    )
  end

  20.times do
    Food.create(
      name: Faker::Name.name,
      measurement_unit: "kg",
      price: Faker::Number.decimal(l_digits: 2),
      quantity: Faker::Number.number(digits: 2),
      user_id: prng.rand(1..20)    
    )
  end

  20.times do
    RecipeFood.create(
      quantity: Faker::Number.number(digits: 2),
      recipe_id: prng.rand(1..20),
      food_id: prng.rand(1..20)     
    )
  end

  puts "Data Seeded."

rescue ActiveRecord::RecordInvalid => e
  puts "Validation error occurred: #{e.message}"
end