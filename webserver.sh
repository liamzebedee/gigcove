if [ $RAILS_ENV = 'production' || $RACK_ENV = 'production' ] then 
	echo "Pre-compiling assets"
	rake assets:precompile 
fi
bundle exec rackup -p 3000
