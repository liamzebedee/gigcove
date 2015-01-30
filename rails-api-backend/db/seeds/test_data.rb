if Rails.env == "development"
	# Tags
	sample_tags = [
		"Music",
		"Dance",
		"Visual Art",
		"Film",
		"Exercise",
		"Food"
	]
	sample_tags.each do |tag_name|
		Tag.create(name: tag_name, moderated: true, approved: true)
	end

	# Venues and gigs
	venue_i = 0
	20.times do
		venue_i += 1
		venue = Venue.new
		venue.assign_attributes({
			name: "Venue \##{venue_i}",
			location: "#{venue_i} George St, Brisbane",
			website: "http://example.com",
			approved: true
		})
		venue.save!

		gig_i = 0
		3.times do
			gig_i += 1
			gig = Gig.new
			gig.assign_attributes({
				name: "Gig \##{gig_i}",
				start_datetime: Time.now,
				end_datetime: Time.now + 2.days,
				cost: 10,
				eighteen_plus: true,
				description: "Some description goes here of what is going on in...",
				link_to_source: "http://example-venue-#{venue_i}.com/gigs/#{gig_i}",
				approved: true,
				moderated: true
			})
			puts gig.tags
			gig.tags << Tag.find(name: sample_tags[gig_i   % sample_tags.length])
			gig.tags << Tag.find(name: sample_tags[gig_i+1 % sample_tags.length])
			gig.tags << Tag.find(name: sample_tags[gig_i+2 % sample_tags.length])
			gig.venue = venue
			gig.save!
		end
	end
end