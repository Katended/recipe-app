class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def new
    @recipe = Recipe.new
  end

  def add_ingredient
    @recipe = Recipe.left_outer_joins(:recipe_foods).select('recipes.*,recipe_foods.quantity').find(params[:id])

    if current_user == @recipe.user
      @foods_not_in_recipe = Food.where.not(id: @recipe.foods.pluck(:id))

      if params[:recipe].present? && params[:recipe][:food_ids].present?
        food_ids = params[:recipe][:food_ids].reject(&:empty?) # Remove empty strings
        Food.where(id: food_ids).each do |food|
          RecipeFood.create!(food:, recipe: @recipe, quantity: params[:recipe][:quantity])
        end
        flash[:notice] = 'Ingredients added successfully.'
        redirect_to @recipe
        return
      end
    else
      flash[:alert] = 'You do not have permission to add ingredients to this recipe.'
    end

    render 'add_ingredient'
  end

  def show
    @recipe = Recipe.find(params[:id])
    @user = @recipe.user
    @recipe_food = @recipe.foods.joins(:recipe_foods).select('foods.*,recipe_foods.quantity').distinct
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])

    if @recipe.user == current_user

      @recipe.update(public: !@recipe.public)

      flash[:notice] = @recipe.public ? 'Recipe is now public.' : 'Recipe is now private.'
    else
      flash[:alert] = 'You do not have permission to toggle this recipe.'
    end
    redirect_to @recipe
  rescue StandardError => e
    flash[:notice] = "An error occurred: #{e.message}"
  end

  def remove_food
    @recipe = Recipe.find_by(id: params[:id])
    @recipe_food = RecipeFood.find_by(food_id: params[:food_id], recipe_id: params[:id])

    begin
      if current_user == @recipe.user
        RecipeFood.delete(@recipe_food)

        flash[:notice] = 'Ingredient removed successfully.'
      else

        flash[:alert] = 'You do not have permission to remove ingredients from this recipe.'
      end

      redirect_to @recipe
    rescue StandardError => e
      flash[:notice] = "An error occurred: #{e.message}"
    end
  end

  def public_recipes
    @public_recipes = Recipe.where(public: true).includes(:foods)
    @total_food_items = Food.sum(:quantity)
    @total_price = Food.joins(:recipe_foods).sum('foods.quantity * foods.price')
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    begin
      if @recipe.save
        flash[:notice] = 'Recipe created successfully.'
        redirect_to recipe_path(@recipe)

      else
        flash.now[:alert] = 'Recipe creation failed.'

        redirect_to new_recipe_url
      end
    rescue StandardError => e
      flash[:notice] = "An error occurred: #{e.message}"
    end
  end

  def generate_shopping_list
    @recipe = Recipe.find(params[:id])
  
    # Select all the foods associated with the current recipe through recipe_foods
    @required_foods = @recipe.recipe_foods.map(&:food)
  
    @total_value = @required_foods.sum { |food| food.quantity.to_i * food.price.to_f }
  end
  

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.user == current_user
      @recipe.recipe_foods.destroy_all

      @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully.'
    else
      flash[:alert] = 'You do not have permission to delete this recipe.'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
