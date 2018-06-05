module TransUnion::TLO
  class VehicleSearch
    extend Savon::Model
    include Constants

    client wsdl: TLO_WSDL
    global :adapter, :excon
    global :convert_request_keys_to, :camelcase

    operations :vehicle_search

    def self.vehicle_search(opts={})
      response = super(message: build_request_hash(opts))
      Response.new(response.body)
    end

    def self.build_request_hash(opts={})
      @base_hash = {
        Username: TransUnion::TLO.username,
        Password: TransUnion::TLO.password,
        DPPAPurpose: TransUnion::TLO.dppa_purpose,
        GLBPurpose: TransUnion::TLO.glb_purpose,
        PermissibleUseCode: TransUnion::TLO.permissible_use_code
      }
      { 'vehicleSearch2Input' => @base_hash.merge(opts) }
    end
  end
end
