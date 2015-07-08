ENV['RACK_ENV'] ||= 'development'
development = ENV['RACK_ENV'] == 'development'

Bundler.require(:default, ENV['RACK_ENV'])
require 'logger'
require 'tilt/haml' # Avoids warning message from tilt.

Dir.glob('./config/initializers/*', &method(:require))

Unreloader = Rack::Unreloader.new(reload: development,
                                  logger: Logger.new(STDOUT),
                                  subclasses: %w(Roda)) { GetSwole::App }

Unreloader.require './get_swole.rb'
