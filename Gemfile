source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.2', '>= 6.0.2.1'   # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'jquery-rails'    # Add jquery for bootstrap
gem 'will_paginate'   # Add paginate required Gems
gem 'bootstrap-will_paginate'

gem 'hirb'            # Add HIRB Table viewer
gem 'bcrypt'          # Adds the cryptographic hash function tool bcrypt
gem 'bootstrap-sass'  # Adds Less to Sass converter for Bootstrap integration
gem 'rubocop'         # Adds Rubocop for linter tests

# some edits for Security updates, per GitHub requests
gem 'puma', '>= 4.3.3'        # Use Puma as the app server
gem "nokogiri", ">= 1.10.8"   # Upgrade nokogiri to version 1.10.8 or later.
gem 'sass-rails', '>= 6'      # Use SCSS for stylesheets
gem 'webpacker', '~> 4.0'     # Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'turbolinks', '~> 5'      # Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'jbuilder', '~> 2.7'      # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'sqlite3', '~> 1.4'    # Use sqlite3 as the database for Active Record
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]    # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'faker'
end

group :development do
  gem 'web-console', '>= 3.3.0'     # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'            # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  
  gem 'better_errors'     # Gems suggested by appacademy.io
  gem 'binding_of_caller'
  gem 'pry-rails'
end

group :test do
  gem 'capybara', '>= 2.15'       # Adds support for Capybara system testing and selenium driver
  gem 'selenium-webdriver'

  gem 'webdrivers'                # Easy installation and use of web drivers to run system tests with browsers

  gem 'rails-controller-testing'  # TESTING GEMS
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'guard'
  gem 'guard-minitest'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
