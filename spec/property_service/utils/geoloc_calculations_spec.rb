require "spec_helper"

describe PropertyService::Utils::GeolocCalculations do

  let(:klass) { PropertyService::Utils::GeolocCalculations }

  let(:starting_location_1) { {:latitude => "21.00", :longitude => "10.00"} }
  let(:starting_location_2) { {:latitude => "-21.00", :longitude => "10.00"} }
  let(:starting_location_3) { {:latitude => "-21.00", :longitude => "-10.00"} }
  let(:starting_location_4) { {:latitude => "21.00", :longitude => "-10.00"} }

  let(:target_location_1) { {:latitude => "-45.00", :longitude => "-5.00"} }
  let(:target_location_2) { {:latitude => "-45.00", :longitude => "5.00"} }
  let(:target_location_3) { {:latitude => "45.00", :longitude => "-5.00"} }
  let(:target_location_4) { {:latitude => "45.00", :longitude => "5.00"} }

  context ".EARTH_RADIUS" do
    it "provides Earth's radius" do
      expect(klass::EARTH_RADIUS).to eq 6371
    end
  end

  context "#is_in_proximity?" do
    context "when the second location is too far away" do
      it "returns false" do
        expect(
          klass.is_in_proximity?(starting_location_1, target_location_1, 7493.0)
        ).to be_false
      end
    end

    context "when the second location is close enough" do
      it "returns true" do
        expect(
          klass.is_in_proximity?(starting_location_2, target_location_2, 2708.0)
        ).to be_true
      end
    end
  end

  context "#calculate_distance" do
    it "calculates proximity" do
      expect(
        klass.calculate_distance(starting_location_1, target_location_1).round(2)
      ).to eq 7494.9

      expect(
        klass.calculate_distance(starting_location_2, target_location_2).round(2)
      ).to eq 2707.76

      expect(
        klass.calculate_distance(starting_location_3, target_location_3).round(2)
      ).to eq 7356.37

      expect(
        klass.calculate_distance(starting_location_4, target_location_4).round(2)
      ).to eq 3001.63
    end
  end

  context "#degrees_to_radians" do
    it "converts degrees to radians" do
      expect(klass.degrees_to_radians(15.125656).round(9).to_s("F")).to eq "0.263992499"
      expect(klass.degrees_to_radians(85.12565688).round(9).to_s("F")).to eq "1.485722993"
    end
  end

end