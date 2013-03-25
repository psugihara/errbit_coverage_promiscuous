Airbrake.configure do |config|
  config.development_environments = []
  config.api_key = '2d909dab88a848e8658e743cf9f3d80b'
  config.host    = '0.0.0.0'
  config.port    = 3000
  config.secure  = config.port == 443
end