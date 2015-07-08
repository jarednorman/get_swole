desc "Open a pry session"
task console: :environment do
  Bundler.require(:pry)
  TOPLEVEL_BINDING.pry
end
