require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module PupShare
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
#     config.action_controller.include_all_helpers = false
  end
  

end
