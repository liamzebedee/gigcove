class RemoveTicketTypeFromGig < ActiveRecord::Migration
  def change
    remove_column :gigs, :ticketType
    remove_column :gigs, :online_tickets_link
  end
end
