class AddUserRefToRecipesFood < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes_food, :user, null: false, foreign_key: true
  end
end
