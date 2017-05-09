module TransUnion::TLO
  class BasicPersonSearch
    class Response
      def initialize(response={})
        @response = response
      end

      def full_hash
        @response
      end

      def result
        @response[:basic_person_search_response][:basic_person_search_result]
      end

      def output_records
        result[:basic_person_search_output_records][:basic_person_search_output_record]
      end
    end
  end
end
