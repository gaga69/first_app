class AddLibnameToFavoriteLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :favorite_libraries, :libname, :string
  end
end
