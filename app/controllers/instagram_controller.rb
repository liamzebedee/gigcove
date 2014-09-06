require "instagram"

# TODO Instagram's API is stupid as hell
# We should subscribe to both location/latlng


# class InstagramMedia
# 	link # http://instagr.am/p/BWl6P/
# 	id # 22699663
# 	created_time # 1296703540
# end

# class InstagramData
# 	attr_accessible :new_media_count
# 	last_seen_id

# 	on_change in new_media_count :update

# 	def update
# 		return if new_media_count < 15
# 		media = client.get_new_data(#gigcove/, count: 30)
# 		self.last_seen_id = media.pageination_start

# 		media.each do |media_item|
# 			location = ""
# 			latlng = []
# 			venue = Venue.find(location: location, latlng: latlng).first
# 			if venue.exists?
# 				if venue.time within 2.day of next_gig_date
# 					gig.instagram_media << media_item
# 				end
# 			end
# 		end
# 	end
# end

class InstagramController < ApplicationController
	protect_from_forgery :except => [:verify_subscriptions, :update]

	def self.init_subscriptions
		@@client = Instagram.client()
		# New thread so Rails is able to respond to subscription request challenge (below) without waiting on us
		Thread.new do |t|
			begin
				res = @@client.create_subscription(:object => 'tag', :callback_url => Rails.application.routes.url_helpers.instagram_subscription_callback_url, :aspect => "media", :object_id => "nofilter")
				# TODO this logging doesnt work
				if res[:error_message]
					Logger.fatal "Couldn't create Instagram subscription - #{res[:error_type]} #{res[:error_message]}"
				end
			ensure
				Rails.logger.flush
			end
			t.exit
		end
	end

	def verify_subscriptions
		# hub.mode - This will be set to "subscribe"
		# hub.challenge - This will be set to a random string that your callback URL will need to echo back in order to verify you'd like to subscribe.
		# hub.verify_token - This will be set to whatever verify_token passed in with the subscription request. It's helpful to use this to differentiate between multiple subscription requests.
		#val = client.meet_challenge(params)
		# TODO SECURITY
		render :text => params["hub.challenge"]
		#render :text => val if val
	end

	def update
		# FORMAT:
		# [
		#     {
		#         "subscription_id": "1",
		#         "object": "user",
		#         "object_id": "1234",
		#         "changed_aspect": "media",
		#         "time": 1297286541
		#     },
		#     {
		#         "subscription_id": "2",
		#         "object": "tag",
		#         "object_id": "nofilter",
		#         "changed_aspect": "media",
		#         "time": 1297286541
		#     },
		#     ...
		# ]
		#if Instagram.validate_update(request.body, headers)
			new_media_count = 0

			#Instagram.process_subscription('[{"changed_aspect": "media", "object": "tag", "object_id": "nofilter", "time": 1409977088, "subscription_id": 11720800, "data": {}}]') { |handler| handler.on_tag_changed { |tag_id, data| puts '1' } }
			Instagram.process_subscription(request.raw_post) do |handler|
				handler.on_tag_changed do |tag_id, data|
					new_media_count += 1 #if tag_id == '#gigcove'
				end
			end

			Rails.logger.info new_media_count
			#InstagramData.new_media_count += new_media_temp
		#else
		#	render text: "not authorized", status: 401
		#end
	end
end



