class Performance < ActiveRecord::Base
  belongs_to :artist, inverse_of: :performances
  belongs_to :gig, inverse_of: :performances
end
