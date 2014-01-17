# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
User.new({:email => "liam@liamz.co", :moderator => true, :password => "efb445db9a2", :password_confirmation => "efb445db9a2" }).save(:validate => false)
