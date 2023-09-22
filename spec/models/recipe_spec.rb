require 'rails_helper'

RSpec.describe Recipe, type: :model do

  it 'name should be present' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @recipe = Recipe.new(preparation_time: '1.5', cooking_time: '1', user_id: 1)
    expect(@recipe).to_not be_valid
  end

  it 'preparation_time should be present' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @recipe = Recipe.new(name: 'Bread', cooking_time: '1', user_id: 1)
    expect(@recipe).to_not be_valid
  end

  it 'preparation_time should be positive' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1', user_id: 1)
    expect(@recipe).to_not be_valid
  end

  it 'cooking_time should be present' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', user_id: 1)
    expect(@recipe).to_not be_valid
  end

  it 'cooking_time should be positive' do
    @user = User.new(name: 'User', email: 'user@email', password: '753951')
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '-1', user_id: 1)
    expect(@recipe).to_not be_valid
  end

  it 'user should be present' do
    @recipe = Recipe.new(name: 'Bread', preparation_time: '1.5', cooking_time: '1')
    expect(@recipe).to_not be_valid
  end
end
