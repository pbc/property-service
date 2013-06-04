require "json"
module PropertyService
  module DataSuppliers
    class PropertyData

      def all
        data
      end

      def find_in_proximity(options)
        query_options = {
          :proximity => 1.0,
          :latitude => 0.0,
          :longitude => 0.0
        }.merge(options)

        filter_data_by_proximity(query_options)
      end

      private

      def filter_data_by_proximity(options)
        data.select do |element|
          starting_location = select_location_options(options)
          target_location = select_location_options(element)
          is_in_proximity?(starting_location, target_location, options[:proximity])
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
        JSON.parse(IO.read(data_file_path),:symbolize_names => true)
      end

      def data_file_path
        ::PropertyService::Config.instance.properties_source_json_file
      end
    end
  end
end
