# encoding: UTF-8

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path("../../fixtures/net", __FILE__)
  config.default_cassette_options = { record: :none }
  config.hook_into :webmock
  config.filter_sensitive_data("%{API_USERNAME}") { AVALARA_CONFIGURATION["username"] }
  config.filter_sensitive_data("%{API_PASSWORD}") { AVALARA_CONFIGURATION["password"] }
  config.filter_sensitive_data("%{API_ENDPOINT}") { AVALARA_CONFIGURATION["endpoint"] }
  config.configure_rspec_metadata!
end
