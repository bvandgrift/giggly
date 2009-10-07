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
      #    @connection = Giggly::Rest::Request.new(
      #      :api_key    => 'api key provided from Gigya',
      #      :secret_key => 'secret key provided from Gigya',
      #      :user_id    => 'the Gigya User ID',
      #    )
      def initialize(conn_params)
        @api_key      = conn_params[:api_key]
        @secret_key   = conn_params[:secret_key]
        @uid          = conn_params[:user_id]
        @gigya_secret = Base64.decode64(@secret_key)
      end

      # Wraps around HTTParty's post method to make API calls.
      # Responsible for raising errors if they are returned from the API.
      # Returns response data from the post request.
      def post(url, params = {})
        response = self.class.post(url, :query => sign('POST', url, params))
        response_key, response_data = response.shift
        raise_errors(response_data)
        response_data
      end
      
      def sign(http_method, api_url, params)
        params.merge! "apiKey" => @api_key, "uid" => @uid
        params.merge  "sig" => signature(api_url, http_method, params)
      end
      
      def signature(http_method, api_url, params)
        timestamp = Time.now.to_i.to_s
        params.merge!("nonce" => "#{@uid}#{timestamp}", "timestamp" => timestamp) ####
        base_string = build_base_string(http_method, api_url, params)
        hmacsha1 = HMAC::SHA1.digest(@gigya_secret, base_string)
        sig = Base64.encode64(hmacsha1).chomp.to_s.gsub(/\n/,'')
      end
      
      private

        # what is this supposed to do? or when is it supposed to be used?
        def validate_signature(api_url, params, sig)
          sig === signature(api_url, params) 
        end
        
        def params_to_string(params)
          params.sort {|a,b| a[0].to_s <=> b[0].to_s}.collect {|a| "#{a[0]}=#{CGI.escape a[1].to_s}"}.join('&').gsub('+', '%20')
        end
        
        def build_base_string(http_method, api_url, params)
          [http_method, api_url, params_to_string(params)].collect! {|a| CGI.escape a}.join('&')
        end
      
        def raise_errors(data)
          return if '200' == data["statusCode"]
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
