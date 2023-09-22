require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  it 'quantity, food, recipe should be present' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @user.save
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1', description: 'test',
                         user_id: @user.id)
    @recipe.save

    @food = Food.new(name: 'Apple', measurement_unit: 'grams', quantity: 2, price: '10', user_id: @user.id)
    @food.save

    @recipe_food = RecipeFood.new(quantity: '20', food_id: @food.id, recipe_id: @recipe.id)

    @recipe_food.save
    expect(@recipe_food).to be_valid
  end

  it 'quantity should be present' do
    @user = User.new(name: 'User', email: 'use1r@email', password: '753951')
    @user.save
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1', description: 'test',
                         user_id: @user.id)
    @recipe.save

    @food = Food.new(name: 'Apple', measurement_unit: 'grams', price: '10', user_id: @user.id)
    @food.save

    @recipe_food = RecipeFood.new(quantity: '20', food_id: @food.id, recipe_id: @recipe.id)

    @recipe_food.save
    expect(@recipe_food).to_not be_valid
  end

  it 'quantity should be positive' do
    @user = User.new(name: 'User', email: 'use2r@email', password: '753951')
    @user.save

    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1', description: 'test',
                         user_id: @user.id)
    @recipe.save

    @food = Food.new(name: 'Apple', measurement_unit: 'grams', price: '10', user_id: @user.id)
    @food.save

    @recipe_food = RecipeFood.new(quantity: '-20', food_id: 1, recipe_id: 1)

    @recipe_food.save

    expect(@recipe_food).to_not be_valid
  end

  it 'foodshould be present' do
    @user = User.new(name: 'User', email: 'user4@email', password: '753951')
    @user.save
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1', description: 'test',
                         user_id: @user.id)
    @recipe.save

    @food = Food.new(name: 'Apple', measurement_unit: 'grams', quantity: 2, price: '10', user_id: @user.id)
    @food.save

    @recipe_food = RecipeFood.new(quantity: '20', recipe_id: @recipe.id)

    @recipe_food.save

    expect(@recipe_food).to_not be_valid
  end

  it 'recipe should be present' do
    @user = User.new(name: 'User', email: 'user6@email', password: '753951')
    @food = Food.new(name: 'Apple', measurement_unit: 'grams', price: '10', user_id: 1)
    @recipe_food = RecipeFood.new(quantity: '20', food_id: 1)

    expect(@recipe_food).to_not be_valid
  end
end
