module TransUnion::TLO
  class BasicPersonSearch
    extend Savon::Model
    include Constants

    client wsdl: TLO_WSDL
    global :convert_request_keys_to, :camelcase

    operations :basic_person_search

    ## method name needs to match SOAP operation from TLO
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

      { 'genericSearchInput' => @base_hash.merge(parse_options(options)) }
    end

    private

    def self.parse_options(options)
      # snake case is mostly ok except for options such as SSN which needs to be all caps
      ## add any additional normalization into here -- parsing name, etc.
      #
      require_upcase = [:ssn]
      parsed_options = {}
      options.map do |key, value|
        if require_upcase.include? key.to_sym
          parsed_options[key.upcase.to_sym] = value
        else
          parsed_options[key.to_sym] = value
        end
      end
      parsed_options
    end
  end
end
