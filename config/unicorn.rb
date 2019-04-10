worker_processes 3
working_directory '/home/ubuntu/app/current'
timeout 120

listen '/tmp/web_platform.sock', backlog: 2048
pid 'tmp/pids/unicorn-web.pid'

stdout_path 'log/unicorn-web.log'
stderr_path 'log/unicorn-web.log'

preload_app true

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end