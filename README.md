# Get Swole

## Development setup

```sh
# Pull in dependencies.
$ bundle
# Create a get_swole user.
$ createuser -U postgres get_swole
# Create the development and test databases.
$ bundle exec rake db:create
$ RACK_ENV=test bundle exec rake db:create
$ bundle exec rake db:migrate
$ RACK_ENV=test bundle exec rake db:migrate
# Start up the server
$ bundle exec rackup
```
