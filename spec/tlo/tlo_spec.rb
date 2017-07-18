require 'spec_helper'

describe TransUnion::TLO do
  describe '.configure' do
    context 'should allow access to attr_accessor: ' do
      it 'user_name' do
        TransUnion::TLO.configure do |config|
          config.username = 'Bob'
        end
        expect(TransUnion::TLO.username).to eq 'Bob'
      end
      it 'password' do
        TransUnion::TLO.configure do |config|
          config.password = 'secrets'
        end
        expect(TransUnion::TLO.password).to eq 'secrets'
      end
      it 'version' do
        TransUnion::TLO.configure do |config|
          config.version = '33'
        end
        expect(TransUnion::TLO.version).to eq '33'
      end
      it 'dppa_purpose' do
        TransUnion::TLO.configure do |config|
          config.dppa_purpose = '1'
        end
        expect(TransUnion::TLO.dppa_purpose).to eq '1'
      end
      it 'glb_purpose' do
        TransUnion::TLO.configure do |config|
          config.glb_purpose = '1'
        end
        expect(TransUnion::TLO.glb_purpose).to eq '1'
      end
      it 'permissible_use_code' do
        TransUnion::TLO.configure do |config|
          config.permissible_use_code = '1'
        end
        expect(TransUnion::TLO.permissible_use_code).to eq '1'
      end
      it 'convert_nori_string_values' do
        TransUnion::TLO.configure do |config|
          config.convert_nori_string_values = true
        end
        expect(TransUnion::TLO.convert_nori_string_values).to be true
      end
    end
  end

  #
  # Todo will need to mock out the actual TLO call
  #
  context 'before any request' do
    after(:all) {
      TransUnion::TLO.configure { |config| config.username = 'Bob' }
    }
    it 'should verify all required credentials are present' do
      TransUnion::TLO.configure { |config| config.username = nil }
      expect{ TransUnion::TLO.person_search }.to raise_error(RuntimeError)
      expect{ TransUnion::TLO.basic_person_search }.to raise_error(RuntimeError)
      expect{ TransUnion::TLO.vehicle_search }.to raise_error(RuntimeError)
    end
  end

  describe '.person_search'
  describe '.basic_person_search'
  describe '.vehicle_search'
end
