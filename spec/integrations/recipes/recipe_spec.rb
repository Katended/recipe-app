require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :system do
  before(:each) do
    @user1 = User.create(name: 'toyo', email: 'ade@gail.com', password: 'toyman', password_confirmation: 'toyman')
    # post

    @recipe = Recipe.create(name: 'Recipe 1', preparation_time: '1', cooking_time: '1',
                            description: 'This is a test recipe', user: @user1)
  end

  it 'User can see the Recipe page' do
    sign_in @user1
    visit recipes_path
    expect(page).to have_content('Recipe 1')
  end

  it 'User can see the "Delete" button for their own  recipe items' do
    sign_in @user1
    visit recipes_path
    expect(page).to have_button('Remove', count: 1)
  end
end
