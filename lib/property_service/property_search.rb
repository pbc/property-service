module PropertyService
  class PropertySearch
    class << self

      def find_in_proximity(options)
        property_data_supplier.find_in_proximity(options)
      end

      private

      def property_data_supplier
        @property_data_supplier ||= ::PropertyService::DataSuppliers::PropertyData.new
      end

    end
  end
end
