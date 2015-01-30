# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
if User.find_by_email('liam@liamz.co').blank?
  admin_liam = User.new({:email => "liam@liamz.co", :password => "efb445db9a2", :gender => 'male', :full_name => "Liam Zebedee", :password_confirmation => "efb445db9a2", :confirmed_at => Time.now, :roles => [:moderator] }).save(:validate => false)
end

# Load additional seed-ers
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each { |seed| load seed }