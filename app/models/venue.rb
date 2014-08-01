class Venue < ActiveRecord::Base
  # name, :string
  # location, :string
  # website, :text
  has_many :gigs
  
  def get_current_gigs
  	self.gigs.where("start_time >= ?", DateTime.now).limit(10)
  end
  
  def get_previous_gigs
  	self.gigs.where("start_time <= ?", DateTime.now).limit(10)
  end
end
