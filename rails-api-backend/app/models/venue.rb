include Geokit::Geocoders

class Venue < ActiveRecord::Base
  validates_length_of :name, :minimum => 1, :maximum => 200, :allow_blank => false
  validates_length_of :location, :minimum => 1, :maximum => 300, :allow_blank => false
  validates_length_of :website, :minimum => 1, :maximum => 300, :allow_blank => false
  validate :latitude, allow_nil: false
  validate :longitude, allow_nil: false
  
  # name
  # location
  # id
  # website
  # latitude
  # longitude
  has_many :gigs

  acts_as_mappable :distance_field_name => :distance,
    :lat_column_name => :latitude,
    :lng_column_name => :longitude

  def serializable_hash(options)
    super({:only => [:name, :location, :latitude, :longitude, :website, :id]})
  end

  def self.find_similar_to_name(name)
    # upper(name) makes case sensitivity not an issue when searching
    # ordering it descending makes it more logical
    Venue.where("upper(name) LIKE upper(?)", "%#{name}%").order(name: :asc)
  end
end
