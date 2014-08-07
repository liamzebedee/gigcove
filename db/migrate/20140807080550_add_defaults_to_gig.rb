class AddDefaultsToGig < ActiveRecord::Migration
  def change
  	change_column_default :gigs, :
  	change_column_default :gigs, :ticket_cost, 0
  	change_column_default :gigs, :title, ""
  	change_column_default :gigs, :description, ""
  	change_column_default :gigs, :approved, false
  	change_column_default :gigs, :moderated, false
  	change_column_default :gigs, :link_to_source, ""
  end
end
