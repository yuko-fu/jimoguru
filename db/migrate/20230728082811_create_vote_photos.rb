class CreateVotePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_photos do |t|
      t.text :image
      t.string :content
      t.references :vote, null: false, foreign_key: true

      t.timestamps
    end
  end
end
