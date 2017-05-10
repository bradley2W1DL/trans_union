require 'hashdiff'

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

      def consolidate_records(records_array=output_records)
        #
        # Returns a single record for each unique record[:report_token]
        #   - consolidates any unique address / phone records together
        return records_array if records_array.count == 1

        top_record = records_array[0]
        unique_records = records_array.select { |r| r[:report_token] != top_record[:report_token] }
        duplicate_records = records_array.select { |r| r[:report_token] == top_record[:report_token] }

        addresses = []

        duplicate_records.each do |record|
          diffs = HashDiff.diff(top_record[:address_record], record[:address_record])
          addresses << record[:address_record] if diffs.any?
        end
        if addresses.any?
          # returns an array of consolidated addresses instead of the single address hash
          top_record[:address_record] = [top_record[:address_record], addresses].flatten
        end
        # recursive call to consolidate any records that don't match the top_record
        unique_records = consolidate_records(unique_records) if unique_records.any?

        [top_record, unique_records].flatten
      end
    end
  end
end
