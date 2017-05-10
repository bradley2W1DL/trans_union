module TransUnion::TLO
  class BasicPersonSearch
    class Response
      def initialize(response={})
        @response = response
      end

      def full_hash
        @response
      end

      def error?
        result[:error_code] != '0'
      end

      def result
        @response[:basic_person_search_response][:basic_person_search_result]
      end

      def output_records
        result[:basic_person_search_output_records][:basic_person_search_output_record]
      end

      def unique_records
        output_records.uniq { |record| record.values_at(:report_token) }
      end

      def consolidated_records(records_array=output_records)
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

      def address_records
        # {
        #   report_token: '123-blah',
        #   addresses: [
        #     {
        #       line1: '123 45th st.',
        #       city: 'BOULDER',
        #       state: 'CO',
        #       zip: '80026',
        #       county: 'BOULDER'
        #     },
        #     address: '{...}'
        #   ]
        # }
        @_address_records ||= consolidated_records.map do |record|
          ret = {}
          ret[:report_token] = record[:report_token]
          ret[:addresses] = []
          if record[:address_record].is_a? Hash
            ret[:addresses] << record[:address_record][:address]
          else
            ret[:addresses] = record[:address_record].map { |r| r[:address] }
          end
          ret[:addresses] = ret[:addresses].uniq { |a| a.values_at(:line1, :city, :state, :zip) }
          ret
        end
      end

      def phone_records
        # {
        #   report_token: '123-xyz',
        #   phones: [
        #     {
        #       listing_name: 'BARKLEY, GNARLES',
        #       phone_type: 'Mobile',
        #       carrier: 'VERIZON',
        #       carrier_type: 'WIRELESS',
        #       city: '',
        #       state: '',
        #       county: '',
        #       time_zone: 'MT',
        #       score: '80',
        #       phone: '9705552231'
        #     }
        #   ]
        # }
        @_phone_records ||= consolidated_records.map do |record|
          ret = {}
          ret[:report_token] = record[:report_token]
          ret[:phones] = []
          if record[:address_record].is_a? Hash
            ret[:phones] << record[:address_record][:phones][:basic_phone_listing]
          else # Array
            ret[:phones] = record[:address_record].map do |r|
              r[:phones][:basic_phone_listing] unless ret[:phones].include? r[:phones][:basic]
            end
          end
          ret[:phones] = ret[:phones].uniq { |p| p.values_at(:phone, :listing_name, :phone_type) }
          ret
        end
      end
    end
  end
end
