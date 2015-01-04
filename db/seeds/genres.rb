# File.readlines(File.join(Rails.root, 'db', 'seeds', 'genres.txt')).each do |genre|
# 	genre.chomp!
# 	Genre.find_or_create_by(name: genre)
# end