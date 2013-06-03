require "spec_helper"

describe PropertyService::PropertySearch do

  let(:klass) { PropertyService::PropertySearch }
  let(:location) { PropertyService::Entities::Location.new(location_params) }
  let(:search_params) { {
    :longitude => longitude,
    :latitude => latitude,
    :proximity => 1.0
  } }

  let(:longitude) { "51.501000" }
  let(:latitude) { "-0.142000" }

  let(:search_results) { [property_1, property_2] }
  let(:property_1) { PropertyFixtures.all_properties[0] }
  let(:property_2) { PropertyFixtures.all_properties[1] }



  context ".find_in_proximity" do
    context "no properties in the area" do
      let(:longitude) { "99.00" }
      let(:latitude) { "-99.00" }

      it "returns an empty result set" do
        expect(klass.find_in_proximity(search_params)).to eq []
      end
    end

    context "available properties in the area" do
      it "returns nearby properties based on provided location" do
        expect(klass.find_in_proximity(search_params)).to eq search_results
      end
    end

  end
end