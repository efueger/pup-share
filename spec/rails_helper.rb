ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'pry'
require 'faker'
require 'devise'
require 'email_spec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  config.use_transactional_fixtures = true

  config.include Devise::TestHelpers, type: :controller

  config.infer_spec_type_from_file_location!

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
end

