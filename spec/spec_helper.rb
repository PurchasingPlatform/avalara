# encoding: UTF-8

require "rubygems"
require "bundler/setup"
Bundler.require(:default, :development)

# Requires supporting files with custom matchers and macros, etc.,
# in ./support/ and its subdirectories.
Dir[File.expand_path("../support/**/*.rb", __FILE__)].each do |file|
  require(file)
end

FactoryGirl.definition_file_paths = [File.expand_path("../factories", __FILE__)]
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
