Geocoder.configure(

  # geocoding service
  :lookup => :mapquest,
  
  :mapquest => {
    :api_key => "Fmjtd%7Cluur29uyl1%2C8a%3Do5-908slw",
  },
  
  # IP address geocoding service
  :ip_lookup => :maxmind,

  # to use an API key:
  :api_key => "...",

  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

  # caching (see below for details):
  #:cache => Redis.new,
  #:cache_prefix => "..."

)
