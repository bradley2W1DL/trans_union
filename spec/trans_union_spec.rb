require 'spec_helper'

describe TransUnion do
  describe '.smoke_test' do
    it 'should return nil' do
      expect(TransUnion.smoke_test).to be nil
    end
  end
end
