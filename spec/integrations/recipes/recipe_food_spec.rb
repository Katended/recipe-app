require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :system do
  before(:each) do
    @user1 = User.create(name: 'toyo', email: 'ade@gail.com', password: 'toyman', password_confirmation: 'toyman')
    # post

    t.string "name"
    t.string "preparation_time"
    t.string "cooking_time"
    t.string "description"
    t.boolean "public"
    @recipe = Recipe.create(name: 'Recipe 1', preparation_time: '1', cooking_time: '1', description: 'This is a test recipe', user: @user1)
   
  end

  it 'User can see the Recipe page' do
    sign_in @user1
    visit recipe_path
    expect(page).to have_content('Recipe 1')
  end

#   it 'User1 can see food items' do
#     sign_in @user1
#     visit foods_path
#     expect(page).to have_content('Onion')
#   end

#   it 'User2 can see food items' do
#     sign_in @user2
#     visit foods_path
#     expect(page).to have_content('Potato')
#   end

#   it 'User can see the "Add food" link' do
#     sign_in @user1
#     visit foods_path
#     expect(page).to have_link('Add food', href: new_food_path)
#   end

#   it 'User can see the "Delete" button for their own food items' do
#     sign_in @user1
#     visit foods_path
#     expect(page).to have_button('Delete', count: 1)
#   end
end
