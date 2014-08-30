class RenameLatitudeAndLongitudeInVenue < ActiveRecord::Migration
  def change
  	rename_column :venues, :latitude, :lat
  	rename_column :venues, :longitude, :lng
  end
end
