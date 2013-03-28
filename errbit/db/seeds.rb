puts "Seeding database"
puts "-------------------------------"

without_promiscuous do
	# Create an initial Admin User
	admin_username = "errbit"
	admin_email = "errbit@#{Errbit::Config.host}"
	admin_pass  = 'password'

	puts "Creating an initial admin user:"
	puts "-- username: #{admin_username}" if Errbit::Config.user_has_username
	puts "-- email:    #{admin_email}"
	puts "-- password: #{admin_pass}"
	puts ""
	puts "Be sure to change these credentials ASAP!"
	user = User.where(:email => admin_email).first || User.new({
	  :name                   => 'Errbit Admin',
	  :email                  => admin_email,
	  :password               => admin_pass,
	  :password_confirmation  => admin_pass
	})
	user.username = admin_username if Errbit::Config.user_has_username

	user.admin = true
	user.save!

	app_name = 'TestApp'

	app = App.where(name: app_name).first || App.create(name: app_name)

	puts ''
	puts 'Test app config/initializers/errbit.rb should look like this:'
	puts '    Airbrake.configure do |config|'
	puts "      config.api_key = '#{app.api_key}'"
	puts "      config.host    = ERRBIT_HOST"
	puts "      config.port    = ERRBIT_PORT"
	puts '      config.secure  = config.port == 443'
	puts '    end'

end