source 'https://rubygems.org'

ruby '3.3.6'

gem 'dotenv-rails', :groups => [:development, :test]
gem 'bootstrap-sass', '~> 3.3.6'
gem "font-awesome-rails"
gem 'geocoder'
gem 'gmaps4rails'
gem 'faker'
gem 'pry-byebug'
gem 'activesupport'
gem 'paperclip', '~> 6.0'
gem 'aws-sdk-s3', '~> 1.0'  # Updated from old aws-sdk
# gem 'responders'  # Built into Rails 5+

# gem 'private_pub'  # Will migrate to Action Cable
# gem 'thin'  # Replaced by puma
gem 'puma', '>= 6.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# The modern asset pipeline for Rails [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use SCSS for stylesheets (via sassc for better performance)
gem 'sassc-rails'

# Use Terser as compressor for JavaScript assets
gem 'terser'

# Keep Sprockets for existing assets (transitional)
gem 'sprockets-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# gem 'fullcalendar_engine', '~> 1.0', '>= 1.0.6'  # Incompatible with Ruby 3.2+, will replace with modern solution

gem 'ratyrate'
# gem 'rails_12factor', group: :production  # Not needed in Rails 5+

# Performance
gem 'bootsnap', require: false

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :test do
  gem 'simplecov', :require => false
  gem 'shoulda-matchers', '~> 5.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capybara', '~> 3.0'
  gem 'rspec-rails', '~> 6.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 4.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'listen', '~> 3.3'
end

