class Genre < ActiveRecord::Base
  has_and_belongs_to_many :gigs, inverse_of: :genres

  def self.find_similar_to_name(name)
    # upper(name) makes case sensitivity not an issue when searching
    # ordering it descending makes it more logical
  	Genre.where("upper(name) LIKE upper(?)", "%#{name}%").order(name: :desc)
  end
end
