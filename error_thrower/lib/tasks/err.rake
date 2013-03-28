require 'airbrake'

namespace :err do
  ERR_MESSAGES = [
    "ControllerA",
    "ControllerB",
    "ControllerC",
    "ControllerD",
    "ControllerE",
    "ControllerF",
    "ControllerG",
    "ControllerH",
    "ControllerI",
    "ControllerJ",
    "ControllerK",
    "ModelA",
    "ModelB",
    "ModelC",
    "ModelD",
    "ModelE",
    "ModelF",
    "ModelG",
    "ModelH",
    "ModelI",
    "ModelJ",
    "ModelK"
  ]

  desc "Throw some errors."
  task :throw, [:num_errors] => [:environment] do |t, args|
    num_errors = args[:num_errors].to_i
    log_interval = num_errors / 100.0

    puts "Throwing #{num_errors} errors..."

  	(1..num_errors).each do |i|
      e = Exception.new(ERR_MESSAGES[rand(ERR_MESSAGES.length)])
      Airbrake.notify(e, :component => nil, :cgi_data => ENV)
      if i % log_interval == 0
        puts i
      end
    end
  end

end
