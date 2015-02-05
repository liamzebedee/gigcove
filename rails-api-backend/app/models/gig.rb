class Gig < ActiveRecord::Base
  validates :cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_datetime, allow_nil: false
  validate :end_datetime, allow_nil: false
  validate :venue, allow_nil: false
  validates_length_of :name, :minimum => 0, :maximum => 200, :allow_blank => false
  validates_length_of :link_to_source, :minimum => 0, :maximum => 1000, :allow_blank => true
  validates_length_of :description, :minimum => 0, :maximum => 10000, :allow_blank => false

  belongs_to :venue, inverse_of: :gigs
  acts_as_mappable :through => :venue

  validate :tags, allow_nil: false
  has_and_belongs_to_many :tags, inverse_of: :gigs

  

  after_initialize do 
    defaults if self.new_record?
  end

  def self.approved_gigs
    where(approved: true)
  end

  def start_date_str
    self.start_datetime.strftime('%-d/%-m/%Y')
  end

  def start_datetime_str
    # strip because for some reason, ruby doesn't have a 12-hour NO blank-spaced parameter
    self.start_datetime.strftime('%l:%M%P').strip
  end

  def end_datetime_str
    self.end_datetime.strftime('%l:%M%P').strip
  end

  def self.upcoming_gigs(max=10)
    self.where("start_datetime >= ?", Time.zone.now).limit(max)
  end

  def self.past_gigs(max=10)
    self.where("start_datetime <= ?", Time.zone.now).limit(max)
  end

  def self.cheaper_than(cost)  
    self.where("cost <= ?", cost)  
  end

  private
    def defaults
      # I would set this in the database, but the datetime would be static
      # A gig is not going to be set in the past, so we set the datetimes here to get them fresh
      self.start_datetime = Time.zone.now
      self.end_datetime = Time.zone.now + 3.hours
      self.approved = false
      self.moderated = false
      self.venue = Venue.new
    end
end
