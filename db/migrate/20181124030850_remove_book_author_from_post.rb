class RemoveBookAuthorFromPost < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :book_author, :string
  end
end
