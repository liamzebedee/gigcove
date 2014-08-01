class AddNameToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :name, :string
  end
end
