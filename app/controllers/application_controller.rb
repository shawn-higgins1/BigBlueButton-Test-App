$:.unshift File.expand_path(File.dirname(__FILE__))
$:.unshift File.join(File.expand_path(File.dirname(__FILE__)), '..', 'lib')

require 'bigbluebutton_api'
require 'yaml'

class ApplicationController < ActionController::Base
    def initBBBApi(env = "")
        config_file = File.join(File.dirname(__FILE__), '..', '..', 'config', 'bbb-config.yml')
        unless File.exist? config_file
            puts config_file + " does not exists. Copy the example and configure your server."
            puts "cp features/config.yml.example features/config.yml"
            puts
            throw Exception.new(config_file + " does not exists. Copy the example and configure your server.")
        end
        @config = YAML.load_file(config_file)

        if !env.empty?
            unless @config['servers'].has_key?(env)
            throw Exception.new("Server #{env} does not exists in your configuration file.")
            end
            server = @config['servers'][env]
        else
            key = @config['servers'].keys.first
            server = @config['servers'][key]
        end

        @api = BigBlueButton::BigBlueButtonApi.new(server['url'], server['secret'], server['version'].to_s, true) 
    end
end
