# require 'trans_union/tlo/client'

require 'trans_union/tlo/basic_person_search'
require 'trans_union/tlo/basic_person_search/response'

module TransUnion
  module TLO

    class << self
      attr_accessor :username, :password, :dppa_purpose, :glb_purpose,
                    :permissible_use_code, :version, :wsdl

      def configure
        yield self
      end

      def basic_person_search(options={})
        ## returns a BasicPersonSearch::Response object
        BasicPersonSearch.basic_person_search(options)
      end

      def vehicle_search(options={})
        # todo need to implement
      end
    end
  end
end
