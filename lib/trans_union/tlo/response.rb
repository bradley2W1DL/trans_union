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
      @response
    end

    def error?
      result[:error_code] != '0'
    end

    #
    # todo add the generic error messaging here ??
    #
  end
end
