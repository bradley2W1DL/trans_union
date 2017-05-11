module TransUnion::TLO
  class VehicleSearch
    class Response < TransUnion::TLO::Response
      def result
        @response[:vehicle_search_response][:vehicle_search_result]
      end

      def vehicles_array
        result[:vehicles][:tlo_vehicle]
      end

      def vehicle_info_array
        ret = []
        vehicles_array.each do |vehicle|
          v = vehicle.dup
          v.delete(:registrants)
          ret << v
        end
        ret
      end

    end
  end
end
