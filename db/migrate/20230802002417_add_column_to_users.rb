class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :prefecture, :integer, null: false
  end
end
