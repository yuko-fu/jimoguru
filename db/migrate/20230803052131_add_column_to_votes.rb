class AddColumnToVotes < ActiveRecord::Migration[6.1]
  def change
    add_column :votes, :image, :text
    add_column :votes, :content, :string

  end
end
