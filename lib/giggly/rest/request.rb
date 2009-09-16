module Giggly
  module Rest
    class Request
      include HTTParty
      attr_accessor :api_key, :secret_key, :uid
      format :xml
      
      def initialize(conn_params)
        @api_key, @secret_key, @uid = conn_params[:api_key], conn_params[:secret_key], conn_params[:uid]
        # should we allow the user to doom themeselves?  probably.
      end

      def post(uri, params = {})
        response = self.class.post(uri, :query => sign(params))
        response_key, response_data = response.shift
        raise_errors(response_data)
        response_data
      end
      
      private
      
      def sign(params)
        timestamp = Time.now().to_i
        params.merge({
          "apiKey" => @api_key,
          "timestamp" => timestamp,
          "nonce" => timestamp,
          "uid" => @uid,
          "sig" => Giggly::Rest::signature(@api_key, @secret_key, timestamp.to_s) 
         })        
      end
      
      def raise_errors(data)
        return if "200" == data["statusCode"] 
        case data["statusCode"].to_i
          when 400
            raise Giggly::Rest::BadRequest.new(data)
          when 401
            raise Giggly::Rest::Unauthorized.new(data)
          when 403
            raise Giggly::Rest::Forbidden.new(data)
          when 404
            raise Giggly::Rest::NotFound.new(data)
          when 413
            raise Giggly::Rest::RequestEntityTooLarge.new(data)
          when 500
            raise Giggly::Rest::InternalServerError.new(data)
          when 503
            raise Giggly::Rest::NotImplemented.new(data)
        end
      end
            
    end
  end
end
