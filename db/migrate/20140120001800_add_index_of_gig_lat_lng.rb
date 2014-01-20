class AddIndexOfGigLatLng < ActiveRecord::Migration
  def self.up
    add_index :gigs, [:latitude, :longitude]
  end

  def self.down
    remove_index :gigs, [:latitude, :longitude]
  end
end
