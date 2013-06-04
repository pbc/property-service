module PropertyService
  module Utils
    class GeolocCalculations

      # in "km"
      EARTH_RADIUS = 6371

      class << self

        def is_in_proximity?(starting_location, target_location, distance_limit)
          proximity = calculate_distance(starting_location, target_location)
          proximity <= distance_limit
        end

        # requires locations in the following format:
        #  {
        #    :latitude => "-45.00",
        #    :longitude => "-5.00"
        #  }
        def calculate_distance(starting_location, target_location)
          start_loc_latitude = degrees_to_radians(starting_location[:latitude])
          start_loc_longitude = degrees_to_radians(starting_location[:longitude])

          target_loc_latitude = degrees_to_radians(target_location[:latitude])
          target_loc_longitude = degrees_to_radians(target_location[:longitude])

          destination_latitude = target_loc_latitude - start_loc_latitude
          destination_longitude = target_loc_longitude - start_loc_longitude

          a = (Math.sin(destination_latitude / 2))**2 + Math.cos(start_loc_latitude) *
              (Math.sin(destination_longitude / 2))**2 * Math.cos(target_loc_latitude)

          c = 2 * Math.atan2( Math.sqrt(a), Math.sqrt(1-a))
          c * EARTH_RADIUS
        end

        def degrees_to_radians(degrees)
          BigDecimal.new(degrees, 8) * Math::PI / BigDecimal.new(180, 8)
        end
      end
    end
  end
end
