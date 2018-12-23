class AddPrefectureCodeToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :prefecture_code, :integer
  end
end
