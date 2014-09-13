class Artist < ActiveRecord::Base
  validates_length_of :name, :minimum => 0, :maximum => 200, :allow_blank => false

  # website   :text
  # name 			:string
  has_many :performances, inverse_of: :artist

  after_initialize do 
    defaults if self.new_record?
  end

  private

  def defaults
  	@approved = false
  	@moderated = false
  end
end
