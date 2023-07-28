class ChangeColumnsAddnullOnMenus < ActiveRecord::Migration[6.1]
  def change
    change_column :menus, :name, :string, null: false
  end
end
