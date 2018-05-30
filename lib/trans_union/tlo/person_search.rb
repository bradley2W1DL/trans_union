module TransUnion::TLO
  class PersonSearch
    extend Savon::Model
    include Constants

    client wsdl: TLO_WSDL
    global :convert_request_keys_to, :camelcase

    global :ssl_ca_cert_file, '/etc/ssl/certs/entrust-ca-cert.pem'

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
          elsif key.to_sym == :name
            parsed_options[:name] = self.parse_name_options(value)
          elsif value.is_a?(Hash) && key.to_sym != :name
            parsed_options[key.to_sym] = self.parse_options(value)
          else
            parsed_options[key.to_sym] = value.gsub(/\s/, '')
          end
        end
        parsed_options
      end

      def parse_name_options(options)
        parsed_options = {}
        options.map do |key, value|
          if key.to_sym == :first_name
            # just grab the first word of name to strip out middle initials
            split_name = value.split(/\s|-/)
            parsed_options[key.to_sym] = split_name[0]
            unless split_name[1].nil?
              parsed_options[:middle_name] = split_name[1]
            end
          elsif key.to_sym == :last_name
            # need to strip off suffixes
            split_name = value.split(/\s|-/)
            if split_name.length == 1
              parsed_options[:last_name] = value
            else
              suffix = split_name.pop if self::NAME_SUFFIXES.include? split_name[-1].upcase.gsub('.', '')
              parsed_options[:last_name] = split_name.join('')
              parsed_options[:name_suffix] = suffix if suffix
            end
          else
            parsed_options[key.to_sym] = value.gsub(/\s/, '')
          end
        end
        parsed_options
      end

    end
  end
end
