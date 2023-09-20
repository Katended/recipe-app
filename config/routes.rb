Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  # root "articles#index"

  resources :recipes do
    member do
      delete :destroy
      get 'add_ingredient', to: 'recipes#add_ingredient'
      post 'add_ingredient', to: 'recipes#add_ingredient'
      get 'generate_shopping_list', to: 'recipes#generate_shopping_list'
      # post 'generate_shopping_list', to: 'recipes#generate_shopping_list'
      post 'choose_inventory', to: 'recipes#choose_inventory'
      delete 'remove_food'
    end
  end

  get 'public_recipes/index'
  get 'public_recipes/show'
  
end
