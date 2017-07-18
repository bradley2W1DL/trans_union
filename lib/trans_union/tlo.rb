require 'trans_union/tlo/constants'
require 'trans_union/tlo/response'
require 'trans_union/tlo/person_search'
require 'trans_union/tlo/person_search/response'
require 'trans_union/tlo/person_search/basic_response'
require 'trans_union/tlo/vehicle_search'
require 'trans_union/tlo/vehicle_search/response'

module TransUnion
  module TLO
    extend Constants
    class << self
      attr_accessor :username, :password, :dppa_purpose, :glb_purpose,
                    :permissible_use_code, :version, :wsdl, :convert_nori_string_values

      def configure
        yield self
      end

      def person_search(options={})
        verify_credentials
        ## returns PersonSearch::Response object
        PersonSearch.person_search(options)
      end

      def basic_person_search(options={})
        verify_credentials
        ## returns PersonSearch::BasicResponse object
        PersonSearch.basic_person_search(options)
      end

      def vehicle_search(options={})
        verify_credentials
        ## returns VehicleSearch::Response object
        VehicleSearch.vehicle_search(options)
      end

      private

      def verify_credentials
        # checks that all necessary credentials are present before making request
        missing = Constants::REQUIRED_CREDENTIALS.select { |cred| self.send(cred).nil? }
        if missing.any?
          raise "TransUnion::TLO required credential(s) #{missing.join(', ')}, missing.\n Ensure TransUnion::TLO is being initialized correctly"
        end
      end
    end
  end
end
