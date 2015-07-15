# Get Swole

## Development setup

```sh
# Pull in dependencies.
$ bundle

# Create a get_swole user.
$ createuser -U postgres get_swole

# Setup the development database.
$ bundle exec rake db:create db:migrate

# Setup the test database.
$ RACK_ENV=test bundle exec rake db:create db:migrate

# Run tests to make sure things are set up right.
$ bundle exec rspec

# Start up the server
$ bundle exec rackup
```
