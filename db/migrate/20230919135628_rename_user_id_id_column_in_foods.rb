class RenameUserIdIdColumnInFoods < ActiveRecord::Migration[7.0]
  def change
    rename_column :foods, :user_id_id, :user_id
  end
end
