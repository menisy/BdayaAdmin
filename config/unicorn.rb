worker_processes 4

################################################################################
# Adjust your APP_PATH here!!!
################################################################################
APP_PATH = "/home/bdaya" # NO trailing slash

working_directory APP_PATH
listen "/tmp/bdaya.sock", :backlog => 64
listen 1111, :tcp_nopush => true
timeout 30
pid APP_PATH + "/tmp/pids/unicorn.pid"
stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stdout.log"
preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true
before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end

