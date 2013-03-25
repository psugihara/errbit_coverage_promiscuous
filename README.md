To see the Promiscuous error I'm getting:

1. Start the subscriber worker and run TestHere:

	cd TestHere
	bundle install
	bundle exec promiscuous subscribe
	rails s -p 3001

2. Start errbit (the publisher):

	cd errbit
	bundle install
	rake errbit:bootstrap
	rails s

3. Create an errbit app in the GUI at 0.0.0.0:3000.

4. The previous step will give you some settings to put in `error_thrower/config/initializers/errbit.rb`.

5. Throw some errors:

	cd error_thrower
	bundle install
	bundle exec rspec

This will show 4 failing tests which are errors being generated and sent to errbit.

Check the errbit console for the promisuous errors.

I was getting something that looked like a stack overflow but when I just ran it again, it said there was a dependency issue. I've got to get on a plane right now but I'll check in on this tonight.

Nico, if you could take a look at this that would be fantastic.

