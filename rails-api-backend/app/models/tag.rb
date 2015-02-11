class Tag < ActiveRecord::Base
  has_and_belongs_to_many :gigs, inverse_of: :tags

  def serializable_hash(options)
    super({:only => [:name]})
  end

  def to_s
  	self.name
  end

  def self.find_similar_to_name(name)
    # upper(name) makes case sensitivity not an issue when searching
    # ordering it descending makes it more logical
  	Tag.where("upper(name) LIKE upper(?)", "%#{name}%").order(name: :asc)
  end
end
