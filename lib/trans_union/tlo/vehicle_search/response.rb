module TransUnion::TLO
  class VehicleSearch
    class Response < TransUnion::TLO::Response
      def result
        @response[:vehicle_search_response][:vehicle_search_result]
      end

      def vehicle_array
        vehicles = result[:vehicles].nil? ? [] : result[:vehicles][:tlo_vehicle]
        vehicles.is_a?(Array) ? vehicles : [vehicles]
      end

      def vehicle_info_array
        ret = []
        vehicle_array.each do |vehicle|
          v = vehicle.dup
          v.delete(:registrants)
          ret << v
        end
        ret
      end

    end
  end
end
