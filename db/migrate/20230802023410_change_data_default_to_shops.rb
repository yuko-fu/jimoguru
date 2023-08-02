class ChangeDataDefaultToShops < ActiveRecord::Migration[6.1]
  def change
    change_column_default :shops, :prefecture, from: nil, to: "0"
  end
end
