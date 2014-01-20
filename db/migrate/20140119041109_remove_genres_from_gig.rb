class RemoveGenresFromGig < ActiveRecord::Migration
  def change
    remove_column :gigs, :genres
  end
end
