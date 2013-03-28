ErrbitCoverage
================

ErrbreakCoverage subscribes to an Errbit instance and points out places that need more test coverage.

This repo contains 3 rails apps for integration testing and throughput experiments. ErrorThrower reports to Errbit via Airbrake and Errbit pushes error notices along to TestHere (renamed ErrbitCoverage) via Promiscuous.

### Running a workload

0. Make sure Redis and RabbitMQ are both running.

1. Start the Promiscuous worker. We do this first because it creates queues in RabbitMQ.

                $ cd TestHere
                $ bundle exec promiscuous subscribe

2. Start ErrbitCoverage:

                $ cd TestHere
                $ rails s
                
3. Seed and start Errbit:

                $ cd errbit
                $ rake errbit:bootstrap
                $ rails s
                
4. The previous step willl have given an API key for a test Errbit app. Enter this in `error_thrower/config/initializers/errbit.rb`. If errbit is running on a different server, you'll want to enter the host and port as well.

5. Now we can throw errors with the error thrower. These 10,000 should all be caught by Errbit and passed along to ErrbitCoverage:

                $ rake err:throw[10000]
                
