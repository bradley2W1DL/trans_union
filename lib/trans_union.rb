require 'trans_union'
require 'trans_union/tlo'

module TransUnion

  class << self
    ## class methods without needing to have the `self.`

    attr_accessor :user_name, :password, :version, :dppa_purpose, :glb_purpose, :permissible_use_code

    def configure
      # Allows for TransUnion.configure do { |c| c.user_id = 'blahblah' } in an initializer
      yield self
    end

  end
end
