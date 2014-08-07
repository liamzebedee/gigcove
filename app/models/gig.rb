class Gig < ActiveRecord::Base
  validates :ticket_cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_time, allow_nil: false
  validate :end_time, allow_nil: false
  validates_length_of :title, :minimum => 0, :maximum => 140, :allow_blank => false
  validates_length_of :link_to_source, :minimum => 0, :maximum => 1000, :allow_blank => true
  validates_length_of :description, :minimum => 0, :maximum => 10000, :allow_blank => false
  validate :datetimes_must_be_in_the_future

  
  has_many :performances
  belongs_to :venue, inverse_of: :gigs
  has_and_belongs_to_many :genres, inverse_of: :gigs
  
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude,
                   :through => :venue
  
  # link_to_source  :text
  # TODO hype		has_many Hypes
  # TODO rating		has_many Ratings

  def start_date_str
    return "" if start_time.nil?
    start_time.strftime('%-d/%-m/%Y')
  end

  def start_time_str
    # strip because for some reason, ruby doesn't have a 12-hour NO blank-spaced parameter
    start_time.strftime('%l:%M%P').strip
  end

  def end_time_str
    end_time.strftime('%l:%M%P').strip
  end

  def genres_str
    genre_names = []
    genres.map do |genre|
      genre_names << genre.name
    end
    genre_names.join ','
  end

  def artists_str
    artists_names = []
    performances.map do |performance|
      artists_names << performance.artist.name
    end
    artists_names.join ','
  end

  def venue_str
    return "" if venue.nil?
    venue.name
  end

  after_initialize :defaults, unless: :persisted?

  private
    def defaults
      # I would set this in the database, but the datetime would be static
      # A gig is not going to be set in the past, so we set the datetimes here to get them fresh
      self.start_time = Time.now
      self.end_time = Time.now
    end

    def datetimes_must_be_in_the_future
      # must be at least since 2 days ago (to adjust for timezones)
      #if start_time
      #  errors.add(:start_time, 'must be in the future') if !(start_time > 2.days.since(Time.now).to_date)
      #end
      #if end_time
      #  # TODO validate must be after start_time
      #  errors.add(:end_time, 'must be in the future') if !(end_time > 2.days.since(Time.now).to_date)
      #end
    end
end
