class AddShownToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :shown, :boolean
  end
end
