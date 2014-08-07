class Artist < ActiveRecord::Base
  validates_length_of :name, :minimum => 0, :maximum => 200, :allow_blank => false

  # website   :text
  # name 			:string
  has_many :performances, inverse_of: :artist
end
