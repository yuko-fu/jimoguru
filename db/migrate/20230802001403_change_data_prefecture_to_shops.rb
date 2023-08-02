class ChangeDataPrefectureToShops < ActiveRecord::Migration[6.1]
  def change
    change_column :shops, :prefecture, 'integer USING CAST(prefecture AS integer)' 
  end
end
