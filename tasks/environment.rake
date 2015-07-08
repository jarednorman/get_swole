desc "Load the application environment"
task :environment do
  require_relative File.join(PROJECT_ROOT, 'get_swole')
end
