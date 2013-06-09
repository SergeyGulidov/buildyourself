# This file is used by Rack-based servers to start the application.

require "unicorn/oob_gc"
use Unicorn::OobGC, 10

require 'unicorn/worker_killer'
use Unicorn::WorkerKiller::MaxRequests, 3072, 4096
use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2))

require ::File.expand_path('../config/environment',  __FILE__)
run BuildYourSelf::Application

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == ENV["DELAYED_USER"] && password == ENV["DELAYED_PASS"]
  end
end