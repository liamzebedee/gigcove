class AddDescriptionToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :description, :text
  end
end
