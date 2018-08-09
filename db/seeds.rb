# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'byebug'
require 'json'
require 'open-uri'

api_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'

Cocktail.destroy_all if Rails.env.development?
Ingredient.destroy_all if Rails.env.development?
Dose.destroy_all if Rails.env.development?

open(api_url) do |stream|
  quote = JSON.parse(stream.read)
  quote['drinks'].each do |hash|
   ingredient = Ingredient.create(name: hash['strIngredient1'])
  end
  puts "finished!"
end

old_fashioned = Cocktail.create(name: "Old Fashioned")
cuba_libre = Cocktail.create(name: "Cuba Libre")


Dose.create(description: "2 shots", cocktail: old_fashioned, ingredient: Ingredient.find_by(name: "Bourbon"))
Dose.create(description: "one cube", cocktail: old_fashioned, ingredient: Ingredient.find_by(name: "Sugar"))
Dose.create(description: "some", cocktail: old_fashioned, ingredient: Ingredient.find_by(name: "Orange"))
Dose.create(description: "one twist", cocktail: old_fashioned, ingredient: Ingredient.find_by(name: "Bitters"))

Dose.create(description: "double shot", cocktail: cuba_libre, ingredient: Ingredient.find_by(name: "Rum"))
Dose.create(description: "some", cocktail: cuba_libre, ingredient: Ingredient.find_by(name: "Coca-Cola"))
Dose.create(description: "a dash", cocktail: cuba_libre, ingredient: Ingredient.find_by(name: "Lime"))


