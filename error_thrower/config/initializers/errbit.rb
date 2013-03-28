Airbrake.configure do |config|
  config.development_environments = []
  config.api_key = '063bdaaee76d175d43d5bee05ed2efa1'
  config.host    = '0.0.0.0'
  config.port    = 3000
  config.secure  = config.port == 443
  config.rescue_rake_exceptions = true
end