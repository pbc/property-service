require "spec_helper"

describe PropertyService::PropertySearch do

  let(:instance) { PropertyService::PropertySearch.new }
  let(:property_data_supplier) { stub({}) }
  let(:search_params) { stub({}) }
  let(:search_results) { stub({}) }

  before do
    PropertyService::DataSuppliers::PropertyData.stub(:new).and_return(
      property_data_supplier
    )
  end

  context "#find_in_proximity" do
    it "delegates search correctly" do
      property_data_supplier.should_receive(:find_in_proximity)
        .with(search_params).and_return(search_results)

      expect(instance.find_in_proximity(search_params)).to eq search_results
    end
  end

  context "#find_similar_properties" do
    it "delegates search correctly" do
      property_data_supplier.should_receive(:find_similar_properties)
        .with(search_params).and_return(search_results)

      expect(instance.find_similar_properties(search_params)).to eq search_results
    end
  end

end