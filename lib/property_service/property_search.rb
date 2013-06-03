module PropertyService
  class PropertySearch
    class << self

      def find_in_proximity(options)
        property_data_source.find_in_proximity(options)
      end

      private

      def property_data_source
        @property_data_source ||= ::PropertyService::DataSuppliers::PropertyData.new
      end

    end
  end
end
