require 'spec_helper'

describe TransUnion::TLO::Client do
  describe 'initialization' do
    let(:params) {{ ssn: 1234, phone_number: 3035551278 }}

    it 'assign hash arguments' do
      client = TransUnion::TLO::Client.new(params)
      expect(client.params).to eq params
    end
  end
end

