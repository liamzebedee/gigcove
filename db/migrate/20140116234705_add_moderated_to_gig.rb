class AddModeratedToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :moderated, :boolean
  end
end
