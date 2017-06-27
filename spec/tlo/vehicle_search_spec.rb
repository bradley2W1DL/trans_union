require 'spec_helper'

describe TransUnion::TLO::VehicleSearch do
  before(:all) {
    TransUnion::TLO.configure do |c|
      c.username = 'Bob'
      c.password = 's3cr3ts'
      c.dppa_purpose = 1
      c.glb_purpose = 1
      c.permissible_use_code = 1
    end
  }

  let(:options) {
    {
      number_of_records: 5,
      starting_record: 0,
      report_token: '123-ABC'
    }
  }

  describe '.build_request_hash' do
    it 'should return correct request hash' do
      request_hash = TransUnion::TLO::VehicleSearch.build_request_hash(options)
      expect(request_hash).to include(
        "vehicleSearch2Input" => {
          Username: 'Bob',
          Password: 's3cr3ts',
          DPPAPurpose: 1,
          GLBPurpose: 1,
          PermissibleUseCode: 1,
          number_of_records: 5,
          starting_record: 0,
          report_token: '123-ABC'
        }
      )
    end
  end

  describe '.vehicle_search' do
    it 'should return ::VehicleSearch::Response object' do
      pending 'Need to properly mock out a Savon Response here for .vehicle_search mock to work properly'
      expect(
        # TransUnion::TLO::VehicleSearch.vehicle_search(options)
      ).to be_a TransUnion::TLO::VehicleSearch::Response
    end
  end
end
