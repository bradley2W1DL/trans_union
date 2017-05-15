module TransUnion::TLO
  class BasicPersonSearch
    class Response < TransUnion::TLO::Response

      def no_records_found?
        result[:number_of_records_found].to_i == 0
      end

      def result
        @response[:basic_person_search_response][:basic_person_search_result]
      end

      def output_records
        return [] if no_records_found?
        result[:basic_person_search_output_records][:basic_person_search_output_record]
      end

      def unique_records
        # returns an array of unique records by the :report_token
        # Does not mutate the output_records
        #
        return output_records if output_records.nil? || output_records.length == 1

        unique = output_records.uniq { |record| record.values_at(:report_token) }
        # map over duplicated records
        unique.dup.map do |record|
          record.delete(:address_record) # includes any phone recs

          record[:address_records] = address_records_for(record[:report_token])
          record[:phone_records] = phone_records_for(record[:report_token])

          record
        end
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
        #     {
        #       line1: '...'
        #     }
        #   ]
        # }
        #
        # TODO write a test for this => should only return one hash per unique report token
        #
        @_address_records ||=
          begin
            @address_records = {}
            output_records.dup.map do |record|
              next if record[:address_record].nil?

              token = record[:report_token]
              address = hash_except(record[:address_record], :phones)

              if @address_records[token].nil? || @address_records[token].empty?
                @address_records[token] = {
                  report_token: token,
                  addresses: [ address ].flatten
                }
              else
                @address_records[token][:addresses] << address
                @address_records[token][:addresses].flatten!
              end
            end
            @address_records.values
          end
      end

      def address_records_for(report_token)
        records = address_records.select { |record| record[:report_token] == report_token }.first
        records[:addresses] if records
      end

      def phone_records
        # example return...
        # [
        #   {
        #     report_token: '123-xyz',
        #     phones: [
        #       {
        #         listing_name: 'BARKLEY, GNARLES',
        #         phone_type: 'Mobile',
        #         carrier: 'VERIZON',
        #         carrier_type: 'WIRELESS',
        #         city: '',
        #         state: '',
        #         county: '',
        #         time_zone: 'MT',
        #         score: '80',
        #         phone: '9705552231'
        #       }
        #     ]
        #   },
        #   {
        #     report_token: '667-xxx',
        #     phones: [
        #       {
        #         listing_name: '...'
        #       }
        #     ]
        #   }
        # ]
        @_phone_records ||=
          begin
            @phone_records = {}
            output_records.dup.map do |record|
              next if record[:address_record].nil? || record[:address_record][:phones].nil?
              token = record[:report_token]
              puts "map through output_records, #{token}"
              phones = record[:address_record][:phones][:basic_phone_listing].reject { |l| l[:phone].nil? }

              if phones && (@phone_records[token].nil? || @phone_records[token].empty?)
                @phone_records[token] = {
                  report_token: token,
                  phones: [ phones ].flatten
                }
              elsif phones
                @phone_records[token][:phones] << phones
                @phone_records[token][:phones].flatten!
              end
            end
            @phone_records.values
          end
      end

      def phone_records_for(report_token)
        records = phone_records.select { |record| record[:report_token] == report_token }.first
        records[:phones] if records
      end

      #
      # helper method // todo move this somewhere else (different file)
      #
      def hash_except(hash, *keys)
        dup_hash = hash.dup
        keys.each { |key| dup_hash.delete(key) }
        dup_hash
      end

    end
  end
end
