require_relative "../lib/property_service"

PropertyService::Base.configure do
  config.properties_source_json_file = File.join(
    File.dirname(File.expand_path(__FILE__)), "../data_sources/properties.json"
  )
end