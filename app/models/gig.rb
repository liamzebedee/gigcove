class Gig < ActiveRecord::Base
  # ticket_cost         :decimal
  # from                :datetime
  # to                  :datetime
  # eventName           :string
  # venueName           :string
  # location            :text
  # genres              :text
  # ticketType          :enum
  enum ticketType:      [ :at_door, :online, :at_door_and_online ]
  # online_tickets_link :text
  # shown               :boolean
  # moderated           :boolean
end
