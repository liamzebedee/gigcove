class Gig < ActiveRecord::Base
  validates :ticket_cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :from, allow_nil: false
  validate :to, allow_nil: false
  validates_length_of :event_name, :minimum => 0, :maximum => 140, :allow_blank => true
  validates_length_of :venue_name, :minimum => 0, :maximum => 140, :allow_blank => false
  validates_length_of :location, :minimum => 0, :maximum => 250, :allow_blank => false
  validate :datetimes_must_be_in_the_future
  
  def datetimes_must_be_in_the_future
    # must be at least since 2 days ago (to adjust for timezones)
    if from
      errors.add(:from, 'must be in the future') if !(from > 2.days.since(Time.now).to_date)
    end
    if to
      errors.add(:to, 'must be in the future') if !(to > 2.days.since(Time.now).to_date)
    end
  end
  
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :latitude,
                   :lng_column_name => :longitude
  
  # from		:datetime
  # till		:datetime
  # title		:string
  # age_restriction	:integer
  # description		:text
  # location		:text
  # latitude		:float
  # longitude		:float
  # moderated		:boolean
  # approved		:boolean
  
  has_many :performances
  has_one :venue
  has_and_belongs_to_many :genres
  
  # link_to_source	:text
  # TODO hype		has_many Hypes
  # TODO rating		has_many Ratings

  geocoded_by :location
  after_validation :geocode # auto-fetch coordinates
end
