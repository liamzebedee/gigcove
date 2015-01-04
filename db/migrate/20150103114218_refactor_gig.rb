class RefactorGig < ActiveRecord::Migration
  def change
  	drop_table :artists
  	drop_table :genres
  	drop_table :performances

  	rename_column :gigs, :ticket_cost, :cost
  	rename_column :gigs, :start_time, :start_datetime
  	rename_column :gigs, :end_time, :end_datetime
  	rename_column :gigs, :title, :name
  	add_column :gigs, :eighteen_plus, :boolean
  	remove_column :gigs, :age_restriction
  end
end
