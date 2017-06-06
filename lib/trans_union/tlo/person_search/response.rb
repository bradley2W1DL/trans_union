module TransUnion::TLO
  class PersonSearch
    class Response < TransUnion::TLO::Response

      def result
        @response[:person_search_response][:person_search_result]
      end

      def output_records
        return [] if no_records_found?
        records = result[:person_search_output_records][:tlo_person_search_output_record]
        # if only one record is returned, ensure that it's returned as an Array
        records.class == Hash ? [records] : records
      end

    end
  end
end
