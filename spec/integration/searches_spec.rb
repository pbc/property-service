require "spec_helper"

describe PropertyService::PropertySearch do

  let(:instance) { PropertyService::PropertySearch.new }
  let(:property_data_supplier) { stub({}) }
  let(:london_city_hall_location) { {
    :latitude => 51.504828,
    :longitude => -0.078605
  } }

  #let(:search_results) { stub({}) }

  let(:property_1) { (PropertyFixtures.all_properties)[0] }
  let(:property_2) { (PropertyFixtures.all_properties)[1] }
  let(:property_3) { (PropertyFixtures.all_properties)[2] }
  let(:property_4) { (PropertyFixtures.all_properties)[3] }

  context "proximity search" do

    context "looking for something in London in 5km radius from the City Hall" do
      let(:params) { london_city_hall_location.merge({ :proximity => 5.0}) }
      let(:results) { [property_1, property_3] }

      it "returns correct results" do
        expect(instance.find_in_proximity(params)).to eq results
      end
    end

  end

  context "similarity search" do

    context "looking for something simmilar to selected property" do
      let(:params) { london_city_hall_location.merge(
        {
          :proximity => 1.0,
          :min_bedroom_count => property_1[:bedroom_count],
          :latitude => property_1[:latitude],
          :longitude => property_1[:longitude]
        }
      )}
      let(:results) { [property_1] }

      it "returns correct results" do
        expect(instance.find_in_proximity(params)).to eq results
      end
    end

  end

end