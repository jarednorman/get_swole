ENV['RACK_ENV'] ||= 'test'

require './get_swole'

FactoryGirl.find_definitions
FactoryGirl.define do
  to_create { |instance| instance.save }
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
  config.example_status_persistence_file_path = "./tmp/rspec_example_status"
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.mock_with(:rspec) { |c| c.syntax = :expect }
  config.include FactoryGirl::Syntax::Methods

  DatabaseCleaner[:sequel, connection: GetSwole::DB]

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = if example.metadata[:type] == :feature
                                 :truncation
                               else
                                 :transaction
                               end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
