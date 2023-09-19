class CreateRecipesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes_tables do |t|
      t.string :name
      t.string :preparation_time
      t.string :cooking_time
      t.string :description
      t.boolean :public      
      t.timestamps null: false
    end
  end
end
