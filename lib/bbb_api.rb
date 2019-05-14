# frozen_string_literal: true

require 'bigbluebutton_api'

module BbbApi
  def bbb_endpoint
    Rails.configuration.bigbluebutton_endpoint
  end

  def bbb_secret
    Rails.configuration.bigbluebutton_secret
  end

  # Sets a BigBlueButtonApi object for interacting with the API.
  def bbb
    BigBlueButton::BigBlueButtonApi.new(bbb_endpoint, bbb_secret, "0.8")
  end
end
