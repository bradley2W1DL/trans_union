module TransUnion::TLO
  class Response
    ## Base response class
    def initialize(response={})
      @response = response
    end

    def full_response_hash
      @response
    end

    def result
      # this method should be defined in each subclass based on
      # response xml format
      raise ":result method not implemented in sub-class => #{self.class.name}"
    end

    def error?
      result[:error_code] != '0'
    end

    def error_code
      result[:error_code]
    end

    def error_message
      result[:error_message]
    end

    def no_records_found?
      result[:number_of_records_found].to_i == 0
    end
  end
end
