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
    :lng_column_name => :longitude,
    :auto_geocode => {:field => :location, :error_message => 'Could not geocode location'}

  mount_uploader :cover_image, CoverImageUploader

  def get_current_gigs
    self.gigs.where("start_time >= ?", DateTime.now).limit(10)
  end

  def get_previous_gigs
    self.gigs.where("start_time <= ?", DateTime.now).limit(10)
  end
end
