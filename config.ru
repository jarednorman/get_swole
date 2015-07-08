require_relative 'get_swole'

if GetSwole.development?
  require 'rack-livereload'
  use Rack::LiveReload
end

run(GetSwole.development? ?
      GetSwole::Unreloader : GetSwole::App.freeze.app)
