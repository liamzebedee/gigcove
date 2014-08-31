File.readlines('genres.txt').each do |genre|
	Genre.find_or_create_by(name: genre)
end