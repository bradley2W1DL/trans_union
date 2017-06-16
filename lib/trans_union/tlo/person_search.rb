module TransUnion::TLO
  class PersonSearch
    extend Savon::Model
    include Constants

    client wsdl: TLO_WSDL
    global :convert_request_keys_to, :camelcase
    operations :person_search, :basic_person_search

    class << self

      def person_search(options={})
        ## returns a Savon::Response object
        response = super(message: build_request_hash(options))
        Response.new(response.body)
      end

      def basic_person_search(options={})
        response = super(message: build_request_hash(options))
        BasicResponse.new(response.body)
      end

      def build_request_hash(options={})
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

      protected

      def parse_options(options)
        # snake case is mostly ok except for options such as SSN which needs to be all caps
        ## add any additional normalization into here -- e.g. stripping any whitespace from name
        #
        require_upcase = [:ssn]
        parsed_options = {}
        options.map do |key, value|
          if require_upcase.include? key.to_sym
            parsed_options[key.upcase.to_sym] = value.gsub(/\s/, '')
          elsif key.to_sym == :first_name
            # just grab the first word of name to strip out middle initials
            parsed_options[key.to_sym] = value.split(/\s|-/)[0]
          elsif value.is_a? Hash
            parsed_options[key.to_sym] = self.parse_options(value)
          else
            parsed_options[key.to_sym] = value.gsub(/\s/, '')
          end
        end
        parsed_options
      end

    end
  end
end
