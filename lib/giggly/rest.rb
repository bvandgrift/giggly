require 'digest'
require 'hmac-sha1'
require 'base64'
require 'cgi'

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

  end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'rest', 'request')
require File.join(directory, 'rest', 'socialize')