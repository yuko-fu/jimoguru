class ChangeCotegoriesToCategories < ActiveRecord::Migration[6.1]
  def change
    rename_table :cotegories, :categories
  end
end
