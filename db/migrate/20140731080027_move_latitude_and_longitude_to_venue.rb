class MoveLatitudeAndLongitudeToVenue < ActiveRecord::Migration
  def change
    remove_column :gigs, :latitude
    remove_column :gigs, :longitude
    remove_column :gigs, :location
    
    add_column :venues, :latitude, :float
    add_column :venues, :longitude, :float
  end
end
