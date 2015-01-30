class AddEndTimeToGig < ActiveRecord::Migration
  def change
    add_column :gigs, :end_time, :datetime
  end
end
