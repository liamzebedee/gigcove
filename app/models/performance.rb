class Performance < ActiveRecord::Base
  # time          :datetime
  belongs_to :artist
  belongs_to :gig
end
