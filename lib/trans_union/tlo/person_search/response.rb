module TransUnion::TLO
  class PersonSearch
    class Response < TransUnion::TLO::Response
      # handle the parsing of PersonSearch Response

      def result
        @response[:person_search_response][:person_search_result]
      end

      def output_records
        return [] if no_records_found?
        records = result[:person_search_output_records][:tlo_person_search_output_record]
        # if only one record is returned, ensure that it's returned as an Array
        records.class == Hash ? [records] : records
      end

      RECORD_KEYS = [
        :report_token, :ssn_records, :number_of_addresses, :email_addresses, :number_of_bankruptcies,
        :number_of_bankruptcy_records, :number_of_liens, :number_of_judgments, :most_recent_bankruptcy_date,
        :most_recent_bankruptcy_record_date, :names, :dates_of_birth, :addresses, :drivers_licenses,
        :professional_licenses, :other_phones, :sex_offender_records, :relatives
      ]

      def consolidated_record(clean_ssn: true)
        # eliminate any duplication in :ssn_records
        # consolidate dates_of_birth
        # if clean_ssn => also scrub any other instances of SSN from response
      end

      def clean_ssn
        # non-mutational return of record that is scrubbed of all but the top-most instance of SSN
      end

    end
  end
end
