# encoding: UTF-8
require "httparty"
require "avalara/parser"

module Avalara
  class API
    include HTTParty
    headers "Accept" => "application/json", "Content-Type" => "text/json"
    format :json
    parser Parser

    def self.headers_for(length)
      { "Date" => Time.now.httpdate(), "User-Agent" => user_agent_string,  "Content-Length" => length.to_s }
    end

    def self.configuration
      @@_configuration ||= Avalara::Configuration.new
      yield @@_configuration if block_given?
      @@_configuration
    end

    def self.configuration=(configuration)
      raise ArgumentError, "Expected a Avalara::Configuration instance" unless configuration.kind_of?(Configuration)
      @@_configuration = configuration
    end

    def self.configure(&block)
      configuration(&block)
    end

    def self.endpoint
      configuration.endpoint
    end
    def self.endpoint=(endpoint)
      configuration.endpoint = endpoint
    end

    def self.username
      configuration.username
    end
    def self.username=(username)
      configuration.username = username
    end

    def self.password
      configuration.password
    end
    def self.password=(password)
      configuration.password = password
    end

    def self.version
      configuration.version
    end

    def self.version=(version)
      configuration.version = version
    end

    private

    def self.user_agent_string
      "avalara/#{Avalara::VERSION} (Rubygems; Ruby #{RUBY_VERSION} #{RUBY_PLATFORM})"
    end
  end
end

