class Performance < ActiveRecord::Base
  belongs_to :artist, inverse_of: :performances
  belongs_to :gig, inverse_of: :performances

  after_initialize do 
    defaults if self.new_record?
  end

  private

  def defaults
  	@approved = false
  end
end
