#!/env/ruby
File.readlines('schema.rb').each do |line|
	parts = line.split ' '
	unless parts == nil or parts.length < 1 or parts[0] == '#'
		# table
		if parts[0] == 'create_table'
			table_name = parts[1].delete("\"").delete(',')
			puts table_name
		end

		# field
		if parts[0][0] == 't'
			field_name = parts[1].delete("\",").chomp('t.')
			puts ' - '+field_name
		end
	end
end