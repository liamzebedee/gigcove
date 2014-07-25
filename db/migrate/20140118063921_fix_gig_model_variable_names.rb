class FixGigModelVariableNames < ActiveRecord::Migration
  def change
    rename_column :gigs, :eventName, :event_name
    rename_column :gigs, :venueName, :venue_name
  end
end
