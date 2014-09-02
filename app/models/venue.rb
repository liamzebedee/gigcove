class Venue < ActiveRecord::Base
  validates_length_of :name, :minimum => 0, :maximum => 200, :allow_blank => false
  validates_length_of :location, :minimum => 0, :maximum => 300, :allow_blank => false

  # name
  # location
  # website
  # latitude
  # longitude
  has_many :gigs

  acts_as_mappable :distance_field_name => :distance,
    :lat_column_name => :latitude,
    :lng_column_name => :longitude
  before_validation :geocode_address, :on => :update

  def geocode_address
    if !location.blank?
      geo = Geokit::Geocoders::MultiGeocoder.geocode(location)
      errors.add(:address, "Could not Geocode location") if !geo.success
      self.latitude, self.longitude = geo.lat, geo.lng if geo.success
    end
  end

  def geocoded?
    #latitude? && longitude?
  end

  def get_current_gigs
    self.gigs.where("start_time >= ?", DateTime.now).limit(10)
  end

  def get_previous_gigs
    self.gigs.where("start_time <= ?", DateTime.now).limit(10)
  end
end
