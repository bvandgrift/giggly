module Giggly
  module Rest
    class Socialize
      
      GIGYA_URL = "http://socialize.api.gigya.com/socialize."
      
      attr_accessor :request
      
      # Create a new socialize object by passing in a <tt>Giggly::Rest::Socialize</tt> object
      # or by passing in a hash that will be used to initialize a new <tt>Giggly::Rest::Socialize</tt>.
      # See the rdoc for Request to find details for a new connection hash.
      # A <tt>Giggly::Rest::Socialize</tt> is used per user (because the Request object is).
      # example:
      #    @socialize = Giggly::Rest::Socialize.new(@connection)
      def initialize(request)
        @request = request and return if request.kind_of?(Giggly::Rest::Request)
        @request = Giggly::Rest::Request.new(request)
      end

      # Disconnects the user from the provided network.
      # Params::
      # * +network+ array of networks to disconnect from, if emtpy user will be disconnected from all networks
      # Allowed values for network are facebook, myspace, twitter and yahoo.
      def disconnect(provider = nil)
        validate_providers! %w[facebook yahoo myspace twitter], provider
        perform_post :disconnect, :provider => (provider.join(',') if provider)
      end
      
      # retrieves the friends of the current user
      # Params::
      # * +enabled_providers+ comma +separated+ list of providers to include.  (ONLY) 
      # * +disabled_providers+ comma separated list of providers to exclude. (NOT)
      # * +uids+ list of users to retrieve.
      # * +detail_level+ 'basic' or 'extended'
      # Returns::
      # * +Array+ of +Giggly::User+ objects
      def friends_info(options = {})
        validate_providers! %w[facebook yahoo myspace twitter], options[:enabled_providers]
        params = provider_hash(options)
        params[:user_ids], params[:detail_level] = options[:uids], options[:detailLevel]
        
        response = perform_post(:getFriendsInfo, params)
        friends = []
        response['friends']['friend'].each do |friend|
          friends << Giggly::Friend.new(friend)
        end
        friends
      end
      
      # get raw data from an individual provider about a user
      # Params::
      # * +provider+ the provider to retrieve the raw data from, only facebook and myspace are currently supported
      # * +fields+ a array of provider specific fields to retrieve
      # Returns::
      # * +Hash+ of the raw data
      def raw_data(provider, fields)
        validate_providers! %w[facebook myspace], [provider]
        perform_post :getRawData, {:provider => provider, :fields => fields.join(',')}
      end
      
      # get the connection info for a session with a direct api provider
      # this is useful to make calls to a specific provider (not via Socialize)
      # for functions that are currently unsupported by Gigya Socialize
      # Params::
      # * +provider+ the provider to get the connection information for, 
      #   * possible values are facebook, myspace, twitter, or yahoo
      # * +padding_mode+ padding mode for the AES algorithm used in encryping some of the response parameters
      #   * values are PKCS5, PKCS7 or ZEROS PKCS7 will be used as the default
      # See http://wiki.gigya.com/030_Gigya_Socialize_API_2.0/030_API_reference/REST_API/socialize.getSessionInfo on decrypting
      def session_info(provider, padding_mode = 'PKCS7')
        validate_providers! %w[facebook yahoo myspace twitter], [provider]
        # TODO: possibly decrypt response
        Giggly::SessionInfo.new perform_post(:getSessionInfo, {:provider => provider, :paddingMode => padding_mode})
      end
      
      # retrieves user information from gigya, including or excluding providers
      # as indicated.  default usage includes all providers.  returns user.
      # Params::
      # * +providers+ an optional hash of arrays the has the keys of 
      # * +enabled_providers+ an array of provider strings 
      # * +disabled_providers+ an array of provider strings 
      def user_info(providers = {})
        Giggly::User.new perform_post(:getUserInfo, provider_hash(providers))
      end
      
      # see: http://wiki.gigya.com/030_Gigya_Socialize_API_2.0/030_API_reference/REST_API/socialize.publishUserAction
      # for how to create user_action_xml
      def publish_user_action(user_action_xml, providers = {})
        validate_providers! %w[facebook yahoo], providers[:enabled_providers]
        perform_post :publishUserAction, {:userAction => user_action_xml}.merge(provider_hash(providers))
      end
      
      # Sends a notification to a list of friends
      # Params::
      # * +recipients+ a string or array of uids to send the notification to
      # * +subject+ the subject line of the notification
      # * +body+ the body of the notification, do not use html, Gigya will autolink urls
      # this will post to both facebook and twitter
      def send_notification(recipients, subject, body)
        recipients = recipients.is_a?(Array) ? recipients.join(',') : recipients
        perform_post :sendNotification, :recipients => recipients, :subject => subject, :body => body
      end
      
      # sets the status of a user for the given providers (or all of them if blank)
      # Params::
      # * +status+ the status to set for the user
      # * +providers+ an optional hash of arrays the has the keys of 
      # * +enabled_providers+ an array of provider strings 
      # * +disabled_providers+ an array of provider strings
      def set_status(status, providers = {})
        validate_providers! %w[facebook yahoo myspace twitter], providers[:enabled_providers]
        perform_post :setStatus, {:status => status}.merge(provider_hash(providers))
      end
      
      # sets the status of a user for all providers
      # Params::
      # * +status+ the status to set for the user
      # This method will return the status if it is successful, and raise an error on failure
      # Use set status if you want to return the response object
      # Its just in here because we think it looks cool and its convenient
      def status=(status)
        set_status status
      end
      
      protected
      
        def perform_post(action, params = {})
          params.reject! {|k,v| v.nil?}
          @request.post "#{GIGYA_URL}#{action}", params
        end
        
        def provider_hash(providers)
          { :enabledProviders  => (providers[:enabled_providers].join(',') if providers[:enabled_providers]),
            :disabledProviders => (providers[:disabled_providers].join(',') if providers[:disabled_providers]) }
        end
        
        def validate_providers!(valid_providers, given_providers = nil)
          return if given_providers.nil?
          given_providers.each do |provider|
            raise Giggly::Rest::Socialize::InvalidProvider.new(
              "#{provider} is not a valid provider, please only use #{valid_providers.join(' ')}"
            ) unless valid_providers.include? provider
          end
        end
        
        class InvalidProvider < StandardError; end
      
    end
  end
end
