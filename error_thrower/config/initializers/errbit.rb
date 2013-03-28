Airbrake.configure do |config|
  config.development_environments = []
  config.api_key = '02720f964fc41d023ddd1afb33f150da'
  config.host    = '0.0.0.0'
  config.port    = 3000
  config.secure  = config.port == 443
  config.rescue_rake_exceptions = true
end