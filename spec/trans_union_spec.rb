require 'spec_helper'

describe TransUnion, type: :helper do
  describe 'configuration' do
    context 'should allow access to attr_accessor: ' do
      it 'user_name' do
        TransUnion.configure do |config|
          config.user_name = 'Bob'
        end
        expect(TransUnion.user_name).to eq 'Bob'
      end
      it 'password' do
        TransUnion.configure do |config|
          config.password = 'secrets'
        end
        expect(TransUnion.password).to eq 'secrets'
      end
      it 'version' do
        TransUnion.configure do |config|
          config.version = '33'
        end
        expect(TransUnion.version).to eq '33'
      end
      it 'dppa_purpose' do
        TransUnion.configure do |config|
          config.dppa_purpose = '1'
        end
        expect(TransUnion.dppa_purpose).to eq '1'
      end
      it 'glb_purpose' do
        TransUnion.configure do |config|
          config.glb_purpose = '1'
        end
        expect(TransUnion.glb_purpose).to eq '1'
      end
      it 'permissible_use_code' do
        TransUnion.configure do |config|
          config.permissible_use_code = '1'
        end
        expect(TransUnion.permissible_use_code).to eq '1'
      end

    end
  end
end
