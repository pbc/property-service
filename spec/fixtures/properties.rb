class PropertyFixtures
  class << self
    def all_properties
      ::PropertyService::DataSuppliers::PropertyData.new.all
    end
  end
end
