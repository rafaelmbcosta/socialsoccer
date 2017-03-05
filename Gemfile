source 'http://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use Postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'puma', '~> 3.0'
# para o deploy
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'bootstrap', '~> 4.0.0.alpha6'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise', '~> 4.2.0'
# Use ActiveModel has_secure_password
gem 'rails_12factor'
# For AWS storage
gem 'fog'

# File upload gems
gem 'mini_magick'
gem 'carrierwave'
gem "figaro"

gem 'rack-cors', :require => 'rack/cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '=1.6.2'

  # Code quality
  gem 'rubocop', require: false

  # Rspec for rails 5
  gem 'rspec-rails', '~> 3.5'

  # Mock rails models
  gem "factory_girl_rails", "~> 4.4.1"

  # Generate random data for factories
  gem "faker", "~> 1.6.3"

  # Used in rspec tests
  gem "rspec-its"

  # Make easier to test for associations
  gem 'shoulda'

  # Functional testing
  gem 'capybara'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end

group :test do
  # Show test coverage of the aplication
  gem "simplecov"
end

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
