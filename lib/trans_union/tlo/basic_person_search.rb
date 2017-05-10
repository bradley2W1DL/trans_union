# require 'savon'

module TransUnion::TLO
  class BasicPersonSearch
    extend Savon::Model

    ## todo would a hardcoded wsdl ever present a problem? could be passed a configuration value
    client wsdl: 'https://webservice.tlo.com/TLOWebService.asmx?wsdl'
    global :convert_request_keys_to, :camelcase

    operations :basic_person_search

    def self.basic_person_search(options={})
      ## returns a Savon::Response object
      response = super(message: build_request_hash(options))
      Response.new(response.body)
    end

    def self.build_request_hash(options={})
      ## hash params are case-sensitive
      @base_hash = {
        Username: TransUnion::TLO.username,
        Password: TransUnion::TLO.password,
        DPPAPurpose: TransUnion::TLO.dppa_purpose,
        GLBPurpose: TransUnion::TLO.glb_purpose,
        PermissibleUseCode: TransUnion::TLO.permissible_use_code
      }

      { 'genericSearchInput' => @base_hash.merge(options) }
    end
  end
end
