require 'spec_helper'

require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.default_driver = :poltergeist
Capybara.app = GetSwole::App.freeze.app
