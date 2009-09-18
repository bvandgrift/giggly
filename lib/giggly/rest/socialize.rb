module Giggly
  module Rest
    class Socialize
      
      GIGYA_URL = "http://socialize.api.gigya.com/socialize."
      
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
      def disconnect(network = nil)
        perform_post 'disconnect', :provider => (network.join(',') if network)
      end
      
      # retrieves the friends of the current user
      # Params::
      # * +enabledProviders+ comma +separated+ list of providers to include.  (ONLY) 
      # * +disabledProviders+ comma separated list of providers to exclude. (NOT)
      # * +UIDs+ list of users to retrieve.
      # * +detailLevel+ 'basic' or 'extended'
      # Returns::
      # * +Array+ of +Giggly::User+ objects
      def friends_info
        response = perform_post(GIGYA_URL + 'getFriendsInfo', params)
        friends = []
        response['friends'].each do |f|
          friends << Giggly::Friend.new(f['friend'])
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
        perform_post GIGYA_URL + 'getRawData', {:provider => provider, :fields => fields.join(',')}
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
        # TOOD: possibly decrypt response
        Giggly::SessionInfo perform_post(GIGYA_URL + 'getSessionInfo', {:provider => provider, :paddingMode => padding_mode})
      end
      
      # retrieves user information from gigya, including or excluding providers
      # as indicated.  default usage includes all providers.  returns user.
      # Params::
      # * +providers+ an optional hash of arrays the has the keys of 
      # * +included_providers+ an array of provider strings 
      # * +excluded_providers+ an array of provider strings 
      def user_info(providers = {})
        Giggly::User.new perform_post(GIGYA_URL + 'getUserInfo', provider_hash(providers))
      end
      
      # arg, this looks to be more difficult because we have to send a custom xml payload
      # see: http://wiki.gigya.com/030_Gigya_Socialize_API_2.0/030_API_reference/REST_API/socialize.publishUserAction
      def publish_user_action
        perform_post(GIGYA_URL + 'publishUserAction', params)
      end
      
      # Sends a notification to a list of friends
      # Params::
      # * +recipients+ a string or array of uids to send the notification to
      # * +subject+ the subject line of the notification
      # * +body+ the body of the notification, do not use html, Gigya will autolink urls
      # this will post to both facebook and twitter
      def send_notification(recipients, subject, body)
        recipients = recipients.class.name == 'Array' ? recipients.join(',') : recipients
        perform_post GIGYA_URL + 'sendNotification', {:recipients => recipients, :subject => subject, :body => body}
      end
      
      # sets the status of a user for the given providers (or all of them if blank)
      # Params::
      # * +providers+ an optional hash of arrays the has the keys of 
      # * +included_providers+ an array of provider strings 
      # * +excluded_providers+ an array of provider strings
      def status=(status, providers = {})
        perform_post GIGYA_URL + 'setStatus', {:status => status}.merge(provider_hash(providers))
      end
      
      protected
      
        def perform_post(action, params = {})
          params.reject! {|k,v| v.nil?}
          @request.post action.to_s, params
        end
        
        def provider_hash(providers)
          params = {
            :enabledProviders  => (providers[:included_providers].join(',') if providers[:included_providers]),
            :disabledProviders => (providers[:included_providers].join(',') if providers[:excluded_providers])
          }
        end
      
    end
  end
end
