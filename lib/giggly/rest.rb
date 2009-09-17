require 'digest'
require 'hmac-sha1'
require 'base64'

module Giggly
  module Rest
      
    class SocializeError < StandardError
      attr_reader :error_code

      def initialize(error_data)
        @error_code = error_data["errorCode"]
        super(error_data["errorMessage"])
      end
    end

    class BadRequest < SocializeError; end
    class Unauthorized < SocializeError; end
    class Forbidden < SocializeError; end
    class NotFound < SocializeError; end
    class RequestEntityTooLarge < SocializeError; end
    class InternalServerError < SocializeError; end
    class NotImplemented < SocializeError; end
    
    #token is the secret key, value is the nonce.
    def self.signature(key, token, value)
      base_string = "#{token}_#{value}"
      binary_key = Base64.decode64(key) # this is the giggly api key
      unencoded_signature = HMAC::SHA1.hexdigest(binary_key, base_string)
      Base64.encode64(unencoded_signature)
    end

    def self.validate_signature(key, token, value, sig)
      sig == signature(key, token, value) 
    end

  end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'rest', 'request')
require File.join(directory, 'rest', 'socialize')