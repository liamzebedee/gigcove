include Geokit::Geocoders

class Venue < ActiveRecord::Base
  validates_length_of :name, :minimum => 1, :maximum => 200, :allow_blank => false
  validates_length_of :location, :minimum => 1, :maximum => 300, :allow_blank => false
  
  # name
  # location
  # website
  # latitude
  # longitude
  has_many :gigs

  before_validation :geocode_location, :on => [:create, :update]

  acts_as_mappable :distance_field_name => :distance,
    :lat_column_name => :latitude,
    :lng_column_name => :longitude

  def self.find_similar_to_name(name)
    # upper(name) makes case sensitivity not an issue when searching
    # ordering it descending makes it more logical
    Venue.where("upper(name) LIKE upper(?)", "%#{name}%").order(name: :asc)
  end

  private

  def geocode_location(count=0)
    # begin
    begin
      geo = Geokit::Geocoders::MultiGeocoder.geocode(self.location)
      puts 'geocoded', geo.success
      self.latitude, self.longitude = geo.lat, geo.lng if geo.success
    rescue Exception => e
      puts e
      if count == 3
        throw e
      else 
        self.geocode_location(count+1)
      end
      # rescue ActiveRecord::GeocodeError => e
    end

  end
end
