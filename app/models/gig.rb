class Gig < ActiveRecord::Base
  validates :ticket_cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_time, allow_nil: false
  validate :end_time, allow_nil: false
  validates_length_of :title, :minimum => 0, :maximum => 200, :allow_blank => false
  validates_length_of :link_to_source, :minimum => 0, :maximum => 1000, :allow_blank => true
  validates_length_of :description, :minimum => 0, :maximum => 10000, :allow_blank => false
  #validate :datetimes_must_be_in_the_future

  has_many :performances
  belongs_to :venue, inverse_of: :gigs
  has_and_belongs_to_many :genres, inverse_of: :gigs

  acts_as_mappable :through => :venue

  after_initialize do 
    defaults if self.new_record?
  end

  # link_to_source  :text
  # TODO hype		has_many Hypes
  # TODO rating		has_many Ratings

  def start_date_str
    self.start_time.strftime('%-d/%-m/%Y')
  end

  def start_time_str
    # strip because for some reason, ruby doesn't have a 12-hour NO blank-spaced parameter
    self.start_time.strftime('%l:%M%P').strip
  end

  def end_time_str
    self.end_time.strftime('%l:%M%P').strip
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

  private
    def defaults
      # I would set this in the database, but the datetime would be static
      # A gig is not going to be set in the past, so we set the datetimes here to get them fresh
      self.start_time = Time.zone.now
      self.end_time = Time.zone.now + 3.hours
      self.approved = false
      self.moderated = false
      self.venue = Venue.new
    end
end
