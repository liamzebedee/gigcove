class Gig < ActiveRecord::Base
  validates :ticket_cost, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :start_time, allow_nil: false
  validate :end_time, allow_nil: false
  validates_length_of :title, :minimum => 0, :maximum => 140, :allow_blank => false
  validates_length_of :link_to_source, :minimum => 0, :maximum => 1000, :allow_blank => true
  validates_length_of :description, :minimum => 0, :maximum => 10000, :allow_blank => false
  validate :datetimes_must_be_in_the_future
  
  def datetimes_must_be_in_the_future
    # must be at least since 2 days ago (to adjust for timezones)
    if start_time
      errors.add(:start_time, 'must be in the future') if !(start_time > 2.days.since(Time.now).to_date)
    end
    if end_time
      # TODO validate must be after start_time
      errors.add(:end_time, 'must be in the future') if !(end_time > 2.days.since(Time.now).to_date)
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
  # moderated		:boolean
  # approved		:boolean
  
  has_many :performances
  belongs_to :venue
  has_and_belongs_to_many :genres
  
  # link_to_source	:text
  # TODO hype		has_many Hypes
  # TODO rating		has_many Ratings
end
