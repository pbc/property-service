require "rubygems"
require "bundler/setup"

require_relative "../config/boot"

require "webmock/rspec"

PropertyService::Base.configure do
  config.properties_source_json_file = File.join(
    File.dirname(File.expand_path(__FILE__)), "fixtures/properties.json"
  )
end

require "fixtures"

RSpec.configure do |config|

end
