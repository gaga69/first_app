class AddIsbnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :isbn, :bigint
  end
end
