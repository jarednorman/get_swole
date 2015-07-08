worker_processes 4
timeout 30
preload_app true

before_fork do |server, worker|
  GetSwole::DB.disconnect
end

after_fork do |server, worker|
  GetSwole::DB.test_connection
end
