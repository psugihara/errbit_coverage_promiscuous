Airbrake.configure do |config|
  config.development_environments = []
  config.api_key = '53c444d4e069f04e232a2c070a7cc733'
  config.host    = '0.0.0.0'
  config.port    = 3000
  config.secure  = config.port == 443
  config.rescue_rake_exceptions = true
end