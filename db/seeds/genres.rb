File.readlines(File.join(Rails.root, 'db', 'seeds', 'genres.txt')).each do |genre|
	Genre.find_or_create_by(name: genre)
end