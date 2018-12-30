class CreateFavoriteLibraries < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_libraries do |t|
      t.integer :user_id
      t.string :pref
      t.string :city
      t.integer :libid
      t.string :systemid

      t.timestamps
    end
  end
end
