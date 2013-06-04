require "json"
module PropertyService
  module DataSuppliers
    class PropertyData

      def all
        data
      end

      def find_similar_properties(options)
        options = {
          :proximity => 1.0,
          :latitude => 0.0,
          :longitude => 0.0,
          :min_bedroom_count => 1
        }.merge(options)

        STDOUT.puts options

        filtered_data = filter_data_by_proximity(data, options)
        filtered_data = filter_data_by_bedroom_count(filtered_data, options)
        filtered_data
      end

      def find_in_proximity(options)
        options = {
          :proximity => 1.0,
          :latitude => 0.0,
          :longitude => 0.0
        }.merge(options)

        filter_data_by_proximity(data, options)
      end

      private

      def filter_data_by_proximity(provided_data, options)
        provided_data.select do |element|
          starting_location = select_location_options(options)
          target_location = select_location_options(element)
          is_in_proximity?(starting_location, target_location, options[:proximity])
        end
      end

      def filter_data_by_bedroom_count(provided_data, options)
        provided_data.select do |element|
          element[:bedroom_count] >= options[:min_bedroom_count]
        end
      end

      def select_location_options(options)
        options.select do |key, value|
          [:latitude, :longitude].include? key.to_sym
        end
      end

      def is_in_proximity?(starting_location, target_location, distance_limit)
        PropertyService::Utils::GeolocCalculations.is_in_proximity?(
          starting_location, target_location, distance_limit
        )
      end

      def data
        @data ||= JSON.parse(IO.read(data_file_path),:symbolize_names => true)
      end

      def data_file_path
        ::PropertyService::Config.instance.properties_source_json_file
      end
    end
  end
end
