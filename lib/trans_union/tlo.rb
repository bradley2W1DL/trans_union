require 'trans_union/tlo/constants'
require 'trans_union/tlo/response'
require 'trans_union/tlo/basic_person_search'
require 'trans_union/tlo/basic_person_search/response'
require 'trans_union/tlo/vehicle_search'
require 'trans_union/tlo/vehicle_search/response'

module TransUnion
  module TLO
    class << self
      attr_accessor :username, :password, :dppa_purpose, :glb_purpose,
                    :permissible_use_code, :version, :wsdl

      def configure
        yield self
      end

      def basic_person_search(options={})
        ## returns BasicPersonSearch::Response object
        BasicPersonSearch.basic_person_search(options)
      end

      def vehicle_search(options={})
        ## returns VehicleSearch::Response object
        VehicleSearch.vehicle_search(options)
      end
    end
  end
end
