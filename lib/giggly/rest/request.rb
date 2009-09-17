module Giggly
  module Rest
    class Request
      include HTTParty
      attr_accessor :api_key, :secret_key, :uid
      format :xml
      
      # Accepts a hash of connection parameters that will be used to authenticate requests with gigya
      # and specify the user that the request is specific to. The keys for the has are all symbols. 
      # The connection parameter hash requires :api_key, :secret_key, and :uid
      # These are the same parameters that can be passed to the constructor for +Giggly::Rest::Socialize+ 
      # example:
      #  <tt>
      #    @connection = Giggly::Rest::Request.new(
      #      :api_key    => 'api key provided from Gigya',
      #      :secret_key => 'api key provided from Gigya',
      #      :user_id    => 'the Gigya User ID',
      #    )
      #  </tt>
      def initialize(conn_params)
        @api_key, @secret_key, @uid = conn_params[:api_key], conn_params[:secret_key], conn_params[:user_id]
      end

      # Wraps around HTTParty's post method to make API calls.
      # Responsible for raising errors if they are returned from the API.
      # Returns response data from the post request.
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
