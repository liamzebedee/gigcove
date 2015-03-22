Rails API Backend
=================

Dates and times are in rfc3339 format.

## Setup
```
docker-compose run api rake db:create
docker-compose run api rake db:migrate
```

## Updating
`rake db:migrate RAILS_ENV=`. Use `rake secret` to generate new keys for the development and test sections.

## Testing
`docker-compose run api bash`
`rake db:create db:migrate RAILS_ENV=test`
`bundle exec rspec`