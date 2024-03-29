require "spec_helper"

describe PropertyService::DataSuppliers::PropertyData do

  let(:instance) { PropertyService::DataSuppliers::PropertyData.new }

  let(:proximity_search_params) { {
    :latitude => latitude,
    :longitude => longitude,
    :proximity => proximity
  } }

  let(:proximity) { 20.0 }

  let(:similarity_search_params) {
    proximity_search_params.merge({
      :min_bedroom_count => min_bedroom_count
    })
  }

  let(:min_bedroom_count) { 2 }

  let(:latitude) { "51.501000" }
  let(:longitude) { "-0.142000" }

  let(:proxmity_search_results) { [property_1, property_2, property_3, property_4] }
  let(:similarity_search_results_1) { [property_1, property_2, property_3, property_4] }
  let(:similarity_search_results_2) { [property_1, property_2, property_3] }

  let(:property_1) { (PropertyFixtures.all_properties)[0] }
  let(:property_2) { (PropertyFixtures.all_properties)[1] }
  let(:property_3) { (PropertyFixtures.all_properties)[2] }
  let(:property_4) { (PropertyFixtures.all_properties)[3] }



  context "#find_in_proximity" do
    context "no properties in the area" do
      let(:longitude) { "99.00" }
      let(:latitude) { "-99.00" }

      it "returns an empty result set" do
        expect(instance.find_in_proximity(proximity_search_params)).to eq []
      end
    end

    context "available properties in the area" do
      it "returns nearby properties based on provided location" do
        expect(
          instance.find_in_proximity(proximity_search_params)
        ).to eq proxmity_search_results
      end
    end
  end

  context "#find_similar_properties" do
    context "there are no similar properties available" do

      let(:min_bedroom_count) { 2000 }

      it "returns an empty result set" do
        expect(
          instance.find_similar_properties(similarity_search_params)
        ).to eq []
      end
    end

    context "similar properties are available" do

      let(:min_bedroom_count) { 2 }

      it "returns properties with specified min. bedroom count" do
        expect(
          instance.find_similar_properties(
            similarity_search_params.merge({
              :min_bedroom_count => 1
            })
          )
        ).to eq similarity_search_results_1

        expect(
          instance.find_similar_properties(similarity_search_params)
        ).to eq similarity_search_results_2
      end
    end
  end
end