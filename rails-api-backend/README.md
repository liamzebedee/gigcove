Rails API Backend
=================

Dates and times are in rfc3339 format.

## Testing
`docker-compose run api bash`
`rake db:create db:migrate RAILS_ENV=test`
`bundle exec rspec`