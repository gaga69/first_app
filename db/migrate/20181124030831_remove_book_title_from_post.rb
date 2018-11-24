class RemoveBookTitleFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :book_title, :string
  end
end
