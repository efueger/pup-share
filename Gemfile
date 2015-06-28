source 'https://rubygems.org'

gem 'rails', '4.2.0'

gem 'pg'

gem 'devise', '>= 3.2.4'

gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease

gem 'simple_form'

gem 'carrierwave-aws' # picture uploading
# gem 'mini_magick'

gem 'figaro' # secure env variables

group :development do # debugging
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'faker'
  gem 'spring' # speeds up app
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec', require: false ### NOT CONFIGURED, auto-runs specs upon savingbundle exec rspec
end

gem 'rails_12factor', group: :production
gem 'airbrake' ### NOT CONFIGURED, subscription product

gem 'sdoc', '~> 0.4.0', group: :doc # bundle exec rake doc:rails generates the API under doc/api.

gem 'puma' # new server, Heroku/ProductHunt recommended




