class MakeGigMoreDetailed < ActiveRecord::Migration
  def change
    rename_column :gigs, :event_name, :title
    remove_column :gigs, :venue_name
    
    add_column :gigs, :age_restriction, :integer
    
    add_column :gigs, :link_to_source, :text
    
    add_column :gigs, :venue_id, :integer
  end
end
