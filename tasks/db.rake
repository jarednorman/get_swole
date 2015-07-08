namespace :db do
  desc "Create the database for the current RACK_ENV"
  task create: :environment do
    raise unless ["development", "test"].include? ENV['RACK_ENV']
    `createdb -U postgres -O get_swole #{GetSwole.database_name}`
  end

  desc "Drop the database for the current RACK_ENV"
  task drop: :environment do
    raise unless ["development", "test"].include? ENV['RACK_ENV']
    GetSwole::DB.disconnect
    `dropdb -U get_swole #{GetSwole.database_name}`
  end

  desc "Run all pending migrations for the current RACK_ENV"
  task migrate: :environment do
    Sequel.extension :migration
    GetSwole::DB.loggers << Logger.new($stdout)
    Sequel::Migrator.run(GetSwole::DB, 'migrate')
  end

  desc "Drop the database, recreate and migrate it."
  task nuke: [:drop, :create, :migrate]
end
