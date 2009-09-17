module Giggly
  module Rest
    class Socialize
      
      GIGYA_URL = "http://socialize.api.gigya.com/socialize."
      
      # Create a new socialize object by passing in a +Giggly::Rest::Request+ object
      # or by passing in a hash that will be used to initialize a new +Giggly::Rest::Request+.
      # See the rdoc for Request to find details for a new connection hash.
      # A +Giggly::Rest::Socialize+ is used per user (because the Request object is).
      # example:
      #  <tt>
      #    @socialize = Giggly::Rest::Socialize.new(@connection)
      #  </tt>
      def initialize(request)
        @request = request and return if request.kind_of?(Giggly::Rest::Request)
        @request = Giggly::Rest::Request.new(request)
      end

      # Disconnects the user from the provided network.
      # If network is empty, user will be disconnected from all networks.
      # Values for network are facebook, myspace, twitter and yahoo.
      def disconnect(network = nil)
        perform_post :disconnect, :provider => network
      end
      
      # detailLevel	string	This field indicates whether to get basic or extended information about each friend. See the "Friend object" page for details on which fields are included for each detail level.
      # Allowed values are:
      # basic - Basic detail level. This is the default.
      # extended - Extended detail level.
      #   UIDs  string  A comma separated list of UIDs of friends of the current user to get the information for.
      # Note: If both friends and UIDs are missing the method will return all the friends of the current user.
      #   enabledProviders  string  A comma delimited list of provider names to include in the method execution. This parameter gives the possibility to apply this method to only a subset of providers of your choice. If you do not set this parameter, by default, all the providers are enabled (i.e. the method applies to all connected provides). Valid provider names include: facebook, myspace, twitter, yahoo, google, aol.
      # For example, if you would like the method to apply only to Facebook and Twitter, define: enabledProviders=facebook,twitter.
      #   disabledProviders string  A comma delimited list of provider names to exclude in the method execution. This parameter gives the possibility to specify provides that you don't want this method to apply to. If you do not set this parameter, by default, no provider is disabled (i.e. the method applies to all connected provides).Valid provider names include: facebook, myspace, twitter, yahoo, google, aol.
      # For example, if you would like the method to apply to all providers except Google and Twitter, define: disabledProviders=google,twitter.
      def friends_info
        
      end
      
      
      def raw_data
        
      end
      
      def session_info
        
      end
      
      def user_info
        
      end

      def publish_user_action
        
      end
      
      def send_notification
        
      end
      
      def status=(status)
        
      end
      
      protected
      
        def perform_post(action, params = {})
          params.reject! {|k,v| v.nil?}
          @request.post action.to_s, params
        end
      
    end
  end
end