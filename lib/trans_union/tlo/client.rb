module TransUnion::TLO

  class Client
    attr_reader :params

    def initialize(params={})
      # maybe need this maybe not
      @params = params
    end
  end

end
