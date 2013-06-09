root = "/home/deployer/apps/BuildYourSelf/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.BuildYourSelf.sock"
worker_processes 3
timeout 30

after_fork do |server, worker|
	GC.disable
end