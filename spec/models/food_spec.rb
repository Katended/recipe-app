require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before(:each) do
    @user1 = User.create(name: 'toyo', email: 'ade@gail.com', password: 'toyman', password_confirmation: 'toyman')
    @user2 = User.create(name: 'ade', email: 'toyo@gail.com', password: 'toyman1', password_confirmation: 'toyman1')
  end

  it 'title should be present' do
    food = Food.create(name: 'Onion', measurement_unit: 'kg', price: 2.99, quantity: 1, user: @user1)
    food.name = nil
    expect(food).to_not be_valid
  end

  it 'does not change the price if it is already set' do
    food = Food.new(price: 5.99)
    food.valid?
    expect(food.price).to eq(5.99)
  end
end
