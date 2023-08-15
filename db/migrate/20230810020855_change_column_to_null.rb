class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    # Not Null制約を外す場合　not nullを外したいカラム横にtrueを記載
    change_column_null :users, :prefecture, true
  end

  def down
    change_column_null :users, :prefecture, false
  end
end
