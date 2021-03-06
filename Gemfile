# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin AJAX possible
gem 'rack-cors'
# Use to protect API from external calls
gem 'rack-attack'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# jwt authentication
gem 'knock'
# Serializer json
gem 'active_model_serializers'
# exception handler
gem 'rollbar'
# Authorization
gem 'cancancan'
# key value database
gem 'redis'
# background processing
gem 'sidekiq'

group :development, :test do
  # Test framework
  gem 'rspec-rails', '~> 4.0.0'
  # Rspec test auxiliar gem
  gem 'rspec-json_expectations'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # ruby static code analyzer
  gem 'rubocop', require: false
  # check for security vulnerabilities
  gem 'brakeman'
  # deploy gems
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano3-puma', require: false
  gem 'capistrano-rails', '~> 1.3', require: false
  gem 'capistrano-rvm', require: false
end

group :test do
  # Generate record based in a model
  gem 'factory_bot_rails'
  # Fakker datas
  gem 'ffaker'
  # Clean db after test
  gem 'database_cleaner'
  # code coverage
  gem 'simplecov', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
