# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Default credentials (test-install.blindsidenetworks.com/bigbluebutton).
    config.bigbluebutton_endpoint_default = "http://10.80.174.87/bigbluebutton/api" || "http://test-install.blindsidenetworks.com/bigbluebutton/api"
    config.bigbluebutton_secret_default = "d9b1a3bb339a88eb23191ed7154b5cde" || "8cd8ef52e8e101574e400365b55e11a6"

    # Use standalone BigBlueButton server.
    config.bigbluebutton_endpoint = config.bigbluebutton_endpoint_default
    config.bigbluebutton_secret = config.bigbluebutton_secret_default
  end
end
