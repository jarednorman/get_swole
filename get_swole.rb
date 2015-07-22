ENV['RACK_ENV'] ||= 'development'

module GetSwole
  class << self
    def production?
      ENV['RACK_ENV'] == 'production'
    end

    def development?
      ENV['RACK_ENV'] == 'development'
    end

    def database_url
      ENV['DATABASE_URL'] ||
        "postgres://get_swole@localhost/#{database_name}"
    end

    def database_name
      "get_swole_#{ENV['RACK_ENV']}"
    end
  end
end

Bundler.require(:default, ENV['RACK_ENV'])
Bundler.require(:pry) unless GetSwole.production?
require 'logger'
require 'tilt/haml' # Avoids warning message from tilt.

Dir.glob('./config/**/*.rb', &method(:require))

module GetSwole
  Unreloader = Rack::Unreloader.new(
    reload: development?,
    logger: Logger.new(STDOUT),
    subclasses: %w(Roda)
  ) { GetSwole::App }

  Unreloader.require('./get_swole/db.rb')
  Unreloader.require('./get_swole/assets.rb')
  Unreloader.require('./get_swole/models/')
  Unreloader.require('./get_swole/helpers/')
  Unreloader.require('./get_swole/schedule.rb')
  Unreloader.require('./get_swole/app.rb')
end
