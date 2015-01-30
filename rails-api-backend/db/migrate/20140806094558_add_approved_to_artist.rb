class AddApprovedToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :approved, :boolean
  end
end
