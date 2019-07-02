source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.3'
# Use postgresql as the database for Active Record
gem 'pg', ">= 0.18"
# Use Puma as the app server
gem 'puma', "~> 3.11"
# Use SCSS for stylesheets
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', ">= 1.3.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', "~> 2.5"
# Use Redis adapter to run Action Cable in production
# gem 'redis', "~> 4.0"
# Use ActiveModel has_secure_password
# gem 'bcrypt', "~> 3.1.7"

# Use ActiveStorage variant
# gem 'mini_magick', "~> 3.1.7"

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', ">= 1.1.0", require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use RSpec test framework
  gem 'rspec-rails'
  # Generate fake data
  gem 'ffaker'
  # Load environment variables from .env
  gem 'dotenv-rails'
  # Use pry console helper
  gem 'pry-rails'
  # Pretty print Ruby objects
  gem 'awesome_print'
  gem "pry-byebug", "~> 3.7"
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', ">= 3.3.0"
  gem 'listen', ">= 3.0.5"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', "~> 2.0.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'webdrivers'
  # Generate test fixtures
  gem 'factory_bot_rails'
  gem "webmock", "~> 3.6"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Use Devise for authentication
gem 'devise'

# Use CanCanCan for authorization
gem 'cancancan'

  # GraphQL
gem 'graphql'
gem 'graphiql-rails', group: :development
gem 'devise-token_authenticatable'

gem "rack-cors", "~> 1.0"

gem "aws-sdk-s3", "~> 1.43"

gem "stripe", "~> 4.21"
