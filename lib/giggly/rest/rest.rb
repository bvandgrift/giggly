reqiure 'digest'

module Giggly
  module Rest
    
    class SocializeError < StandardError
      attr_reader :error_code, :error_description

      def initialize(error_data)
        @error_code, @error_description = error_data[:error_code], error_data[:description]
        super
      end
    end

    class BadRequest < SocializeError; end
    class Unauthorized < SocializeError; end
    class Forbidden < SocializeError; end
    class NotFound < SocializeError; end
    class RequestEntityTooLarge < SocializeError; end
    class InternalServerError < SocializeError; end
    class NotImplemented < SocializeError; end
    
    def self.signature(token, value)
      base_string = "#{token}_#{value}"
      binary_key = Base64.decode64(Giggly.config["APIKey"])
      unencoded_signature = Digest::SHA1.hexdigest(binary_key, base_string)
      Base64.encode64(unencoded_signature)
    end

    def self.validate_signature(token, value, sig)
      sig == signature(token, value) 
    end
    
  end
end