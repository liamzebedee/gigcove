class AddLatitudeAndLongitudeToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :latitude, :float
    add_column :gigs, :longitude, :float
  end
end
