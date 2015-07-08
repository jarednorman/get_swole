source "https://rubygems.org"

ruby "2.2.2"

gem "roda"
gem "rack-unreloader"
gem "unicorn", require: false
gem "sequel"
gem "pg"
gem "bcrypt"

gem "haml"
gem "susy"
gem "bourbon"
gem "uglifier"
gem "sprockets"
gem "coffee-script"

group :pry do
  gem "pry"
  gem "pry-doc"
  gem "pry-stack_explorer"
end

group :test do
  gem "rspec", "~> 3.3.0"
  gem "factory_girl", "~> 4.0"
  gem "database_cleaner"

  gem "capybara", require: false
  gem "poltergeist", require: false
end

group :development do
  gem "rack-livereload", require: false
  gem "guard-livereload", require: false
end
