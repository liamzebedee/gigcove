class Venue < ActiveRecord::Base
  validates_length_of :name, :minimum => 1, :maximum => 200, :allow_blank => false
  validates_length_of :location, :minimum => 1, :maximum => 300, :allow_blank => false
  
  # name
  # location
  # website
  # latitude
  # longitude
  has_many :gigs

  acts_as_mappable :distance_field_name => :distance,
    :lat_column_name => :latitude,
    :lng_column_name => :longitude,
    :auto_geocode => {:field => :location, :error_message => 'Could not geocode venue location automatically'}

  after_initialize do 
    defaults if self.new_record?
  end

  def self.find_similar_to_name(name)
    # upper(name) makes case sensitivity not an issue when searching
    # ordering it descending makes it more logical
    Venue.where("upper(name) LIKE upper(?)", "%#{name}%").order(name: :desc)
  end

  private

  def defaults
    self.moderated = false
    self.approved = false
    self.name = ""
    self.location = ""
    self.website = ""
  end
end
