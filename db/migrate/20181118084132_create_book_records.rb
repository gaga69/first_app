class CreateBookRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :book_records do |t|
      t.integer :isbn
      t.integer :user_id
      t.string :status

      t.timestamps
    end
    add_index :book_records, [:isbn, :user_id], unique: true
  end
end
