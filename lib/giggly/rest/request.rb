module Giggly
  module Rest
    class Request
      include HTTParty
      attr_accessor :api_key, :secret_key, :uid
      
      def initialize(conn_params)
        api_key, secret_key, uid = conn_params[:api_key], conn_params[:secret_key], conn_params[:uid]
      end

      def post(uri, params = {})
        self.class.post(uri, :query => params.sign)
      end
      
      private
      
      def sign(params)
        params.merge({
          "apiKey" => api_key,
          "timestamp" => timestamp,
          "nonce" => timestamp,
          "uid" => uid,
          "sig" => Giggly::Rest::signature(api_key, timestamp.to_s) 
         })        
      end
      
    end
  end
end
