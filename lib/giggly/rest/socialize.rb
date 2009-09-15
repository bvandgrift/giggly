module Giggly
  module Rest
    class Socialize
      
      GIGYA_URL = "http://socialize.api.gigya.com/socialize."
      
      def initialize(request)
        @request = request and return if request.kind_of?(Giggly::Rest::Request)
        @request = Giggly::Rest::Request.new(request)
      end
      
      def disconnect
        @request.post(GIGYA_URL + "disconnect")
      end
      
    end
  end
end