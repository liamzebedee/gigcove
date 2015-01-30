class RemoveFromTimeFromGig < ActiveRecord::Migration
  def change
    remove_column :gigs, :to
    rename_column :gigs, :from, :start_time
  end
end
