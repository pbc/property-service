module PropertyService
  module DataSuppliers
    class PropertyData

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
          [:latitude, :longitude].include? key
        end
      end

      def is_in_proximity?(starting_location, target_location, distance_limit)
        PropertyService::Utils::GeolocCalculations.is_in_proximity?(
          starting_location, target_location, distance_limit
        )
      end

      def data
        [
          {
            name: "Sizeable house",
            bedroom_count: 2,
            latitude: 51.501000,
            longitude: -0.142000
          },
          {
            name: "Trendy flat",
            bedroom_count: 2,
            latitude: 51.523778,
            longitude: -0.205500
          },
          {
            name: "Flat with stunning view",
            bedroom_count: 2,
            latitude: 51.504444,
            longitude: -0.086667
          },
          {
            name: "Unique flat",
            bedroom_count: 1,
            latitude: 51.538333,
            longitude: -0.013333
          },
          {
            name: "Isolated house",
            bedroom_count: 1,
            latitude: 50.066944,
            longitude: -5.746944
          }
        ]
      end
    end
  end
end
