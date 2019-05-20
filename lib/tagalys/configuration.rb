module Tagalys
  class Configuration
    attr_accessor :client_code, :store_id, :api_key

    def initialize
      @client_code = nil
      @store_id = nil
      @api_key = nil
    end
  end
end
