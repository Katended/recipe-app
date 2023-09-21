require 'rails_helper'


RSpec.describe 'Food Index Page', type: :system do
  before(:each) do
    @user1 = User.create(name: 'toyo', email: 'ade@gail.com', password: 'toyman', password_confirmation: 'toyman')
    @user2 = User.create(name: 'ade', email: 'toyo@gail.com', password: 'toyman1', password_confirmation: 'toyman1')

    # post
    @food1 = Food.create(name: 'Onion', measurement_unit: 'kg', price: 2.99, quantity: 1, user: @user1)
    @food2 = Food.create(name: 'Potato', measurement_unit: 'kg', price: 1.99, quantity: 2, user: @user2)
  end


  it 'User can see the foods page' do
    sign_in @user1
    visit foods_path
    expect(page).to have_content('This is foods page')
  end

  it 'User1 can see food items' do
    sign_in @user1
    visit foods_path
    expect(page).to have_content('Onion')
  end

  it 'User2 can see food items' do
    sign_in @user2
    visit foods_path
    expect(page).to have_content('Potato')
  end

  it 'User can see the "Add food" link' do
    sign_in @user1
    visit foods_path
    expect(page).to have_link('Add food', href: new_food_path)
  end

  it 'User can see the "Delete" button for their own food items' do
    sign_in @user1
    visit foods_path
    expect(page).to have_button('Delete', count: 1)
  end
end
