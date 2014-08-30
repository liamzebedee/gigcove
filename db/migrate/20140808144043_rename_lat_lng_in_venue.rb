class RenameLatLngInVenue < ActiveRecord::Migration
  def change
  	rename_column :venues, :lat, :latitude
  	rename_column :venues, :lng, :longitude
  end
end
