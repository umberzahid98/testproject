# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

:inside confid/enviroment/production.rb
  if you run this on heroku than you will out heroku URL in next line
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
