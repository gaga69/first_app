class ChangeDatatypeIsbnOfBookRecords < ActiveRecord::Migration[5.2]
  def change
    change_column :book_records, :isbn, :bigint
  end
end
