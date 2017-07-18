module TransUnion::TLO
  class PersonSearch
    class Response < TransUnion::TLO::Response

      def result
        @response[:person_search_response][:person_search_result]
      end

      def output_records
        return [] if no_records_found?
        records = result[:person_search_output_records][:tlo_person_search_output_record]
        if TransUnion::TLO.convert_nori_string_values
          records = convert_string_values(records)
        end
        # if only one record is returned, ensure that it's returned as an Array
        records.class == Hash ? [records] : records
      end


      private

      def convert_string_values(element)
        #
        # Savon returns Hash parsed from XML by Nori which results in String values being
        # returned as Nori::StringWithAttributes, this greatly increases the hash's size unnecessarily.
        # Parse the tlo_record and convert any of these classes back to String
        #
        case element
          when Array
            element.each_with_index do |array_element, i|
              element[i] = convert_string_values(array_element)
            end
            element
          when Hash
            element.keys.each do |key|
              element[key] = convert_string_values(element[key])
            end
            element
          when Nori::StringWithAttributes
            # convert element to String class
            element = element.to_s
        end
        element
      end

    end
  end
end
