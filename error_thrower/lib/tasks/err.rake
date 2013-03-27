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
    num_errors = args[:num_errors].to_f

    puts "Throwing #{num_errors} errors..."

  	(1..num_errors).each do
      e = Exception.new(ERR_MESSAGES[rand(ERR_MESSAGES.length)])
      Airbrake.notify(e, :component => nil, :cgi_data => ENV)
    end
  end

end
