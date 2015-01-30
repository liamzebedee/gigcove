class AddDefaultValuesToGig < ActiveRecord::Migration
  def change
    change_column :gigs, :moderated, :boolean, :default => false
    change_column :gigs, :approved, :boolean, :default => false
  end
end
