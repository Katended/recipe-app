class CreateRecipesFood < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_food do |t|
      t.string :quantity
      t.references :recipe, foreign_key: { to_table: :recipes }
      t.timestamps null: false
    end
  end
end