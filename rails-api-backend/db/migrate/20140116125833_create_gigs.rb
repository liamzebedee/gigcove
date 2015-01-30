class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.decimal :ticket_cost
      t.datetime :from
      t.datetime :to
      t.string :eventName
      t.string :venueName
      t.text :location
      t.text :genres
      t.integer :ticketType
      t.text :online_tickets_link

      t.timestamps
    end
  end
end
