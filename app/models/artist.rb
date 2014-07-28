class Artist < ActiveRecord::Base
  # website   :text
  has_many :performances
end
