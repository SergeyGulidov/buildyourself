# This file is used by Rack-based servers to start the application.


require ::File.expand_path('../config/environment',  __FILE__)
run BuildYourSelf::Application

if Rails.env.production?
  DelayedJobWeb.use Rack::Auth::Basic do |username, password|
    username == ENV["DELAYED_USER"] && password == ENV["DELAYED_PASS"]
  end
end