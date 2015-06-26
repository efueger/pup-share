source 'https://rubygems.org'


gem 'rails', '4.2.0'

gem 'pg'

gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'

gem 'simple_form'


# gem 'carrierwave'
gem 'carrierwave-aws' # picture uploading
gem 'mini_magick'

gem 'figaro' # secure env variables

group :development do # debugging
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'airbrake' ### NOT CONFIGURED, subscription product

gem 'devise', '>= 3.2.4'

gem 'factory_girl_rails'

gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# new server, Heroku/ProductHunt recommended
gem 'puma'

# pushes error to std out...? (by default Rails stores errors to txt file and Heroku doesn't read that txt file)
gem 'rails_12factor', group: :production

gem 'minitest-reporters', '~> 1.0.17'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

