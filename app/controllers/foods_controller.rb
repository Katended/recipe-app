class FoodsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

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
      puts "Not saved"
      Rails.logger.error("Validation errors: #{@food.errors}")
    end
  end



  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end

end