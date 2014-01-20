class AddApprovedToGig < ActiveRecord::Migration
  def change
    remove_column :gigs, :shown
    add_column :gigs, :approved, :boolean
  end
end
