class Venue < ActiveRecord::Base
  validates_length_of :name, :minimum => 0, :maximum => 200, :allow_blank => false
  validates_length_of :location, :minimum => 0, :maximum => 300, :allow_blank => false

  # name, :string
  # location, :string
  # website, :text
  # latitude    :float
  # longitude   :float
  has_many :gigs
  
  geocoded_by :location
  after_validation :geocode # auto-fetch coordinates
  
  def get_current_gigs
  	self.gigs.where("start_time >= ?", DateTime.now).limit(10)
  end
  
  def get_previous_gigs
  	self.gigs.where("start_time <= ?", DateTime.now).limit(10)
  end
end
