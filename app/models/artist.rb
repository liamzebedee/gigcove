class Artist < ActiveRecord::Base
  # website   :text
  # name 			:string
  has_many :performances
end
