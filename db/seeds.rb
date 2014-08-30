# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
if User.find_by_email('liam@liamz.co').blank?
  admin_liam = User.new({:email => "liam@liamz.co", :password => "efb445db9a2", :password_confirmation => "efb445db9a2", :confirmed_at => Time.now, :roles => [:moderator] }).save(:validate => false)
end

=begin
Blues
Classic Rock
Country
Dance
Disco
Funk
Grunge
Hip-Hop
Jazz
Metal
New Age
Oldies
Other
Pop
R&B
Rap
Reggae
Rock
Techno
Industrial
Alternative
Ska
Death Metal
Pranks
Soundtrack
Euro-Techno
Ambient
Trip-Hop
Vocal
Jazz+Funk
Fusion
Trance
Classical
Instrumental
Acid
House
Game
Sound Clip
Gospel
Noise
AlternRock
Bass
Soul
Punk
Space
Meditative
Instrumental Pop
Instrumental Rock
Ethnic
Gothic
Darkwave
Techno-Industrial
Electronic
Pop-Folk
Eurodance
Dream
Southern Rock
Comedy
Cult
Gangsta
Top 40
Christian Rap
Pop/Funk
Jungle
Native American
Cabaret
New Wave
Psychadelic
Rave
Showtunes
Trailer
Lo-Fi
Tribal
Acid Punk
Acid Jazz
Polka
Retro
Musical
Rock & Roll
Hard Rock
=end