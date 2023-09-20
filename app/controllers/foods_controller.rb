class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_food, only: %i[show destroy]

  def index
    @foods = Food.all
  end

  def create
    @food = Food.new(food_params)
    @food.user = current_user

    if @food.save
      redirect_to foods_path, notice: 'Food item was successfully created.'
    else
      flash.now[:alert] = 'Food item could not be saved due to the following errors:'
      render :new
      puts 'Not saved'
      Rails.logger.error("Validation errors: #{@food.errors}")
    end
  end

  def destroy
    if @food.destroy
      redirect_to foods_path, notice: 'Food item was successfully deleted.'
    else
      flash.now[:alert] = 'Food item could not be deleted.'
      render :show
    end
  end

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

  private

  def set_food
    @food = Food.find(params[:id])
  end
end
