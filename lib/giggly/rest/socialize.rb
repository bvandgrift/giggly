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
      
      # retrieves the friends of the current user
      # Params::
      # * +enabledProviders+ comma +separated+ list of providers to include.  (ONLY) 
      # * +disabledProviders+ comma separated list of providers to exclude. (NOT)
      # * +UIDs+ list of users to retrieve.
      # * +detailLevel+ 'basic' or 'extended'
      def friends_info
        response = perform_post(GIGYA_URL + "getFriendInfo", params)
        response[:Friends]
        
      end
      
      def raw_data
        perform_post(GIGYA_URL + "disconnect", params)
      end
      
      def session_info
        perform_post(GIGYA_URL + "disconnect", params)
      end
      
      # retrieves user information from gigya, including or excluding providers
      # as indicated.  default usage includes all providers.  returns user.
      # Params::
      # * +enabledProviders+ comma separated list of providers to include.  (ONLY) 
      # * +disabledProviders+ comma separated list of providers to exclude. (NOT)
      def user_info(optional_params = nil)
        Giggly::User.new(perform_post(GIGYA_URL + "disconnect", optional_params))
      end
      
      def publish_user_action
        perform_post(GIGYA_URL + "disconnect", params)
      end
      
      def send_notification
        perform_post(GIGYA_URL + "disconnect", params)
      end
      
      def status=
        perform_post(GIGYA_URL + "disconnect", params)
      end
      
    end
  end
end