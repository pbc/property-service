module PropertyService
  module Entities
    class Location
      attr_accessor :longitude
      attr_accessor :latitude

      def initialize(params)
        @longitude = params[:longitude]
        @latitude = params[:latitude]
      end
    end
  end
end
