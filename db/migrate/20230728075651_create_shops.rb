class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
