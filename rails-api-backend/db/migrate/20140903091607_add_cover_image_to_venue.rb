class AddCoverImageToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :cover_image, :string
  end
end
