class Performance < ActiveRecord::Base
  belongs_to :artist
  belongs_to :gig
end
