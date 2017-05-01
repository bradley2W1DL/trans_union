module TransUnion
  def self.smoke_test
    puts "it's smokey alright"
  end

  class << self
    ## class methods without needing to have the `self.`

    def configure
      yield self
      # Allows for TransUnion.configure do { |c| c.user_id = 'blahblah' }
    end

  end
end
