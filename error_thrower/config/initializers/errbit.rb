Airbrake.configure do |config|
  config.development_environments = []
  config.api_key = '7610ac391dc13eb27fd0f3778474c386'
  config.host    = '0.0.0.0'
  config.port    = 3000
  config.secure  = config.port == 443
end