source 'https://rubygems.org'

ruby '2.5.3'

gem 'activeadmin', '1.0.0'
gem 'delayed_job_active_record', '~> 4.1.2'
gem 'devise'
gem 'pg', '~> 0.21'
gem 'rails', '~> 4.2'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', '~> 4.2.2'
  gem 'sass-rails',   '~> 5.0.7'
  gem 'uglifier'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '3.4.2'
  gem 'rspec-mocks', '3.4.1'
  gem 'test-unit', '~> 3.0'
  gem 'pry-byebug'
  gem 'web-console', '~> 2.0'
  gem 'letter_opener', '~> 1.4'
  gem "capistrano", "~> 3.11", require: false
  gem "capistrano-rails", "~> 1.4", require: false
  gem 'capistrano-rvm'
  gem 'capistrano-rake', require: false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :production do
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem "dotenv-rails"
end
