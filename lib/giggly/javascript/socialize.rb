module Gigya
  module Javascript
    class Socialize
      
      attr_accessor :api_key, :enabled_providers, :disabled_providers
      
      def initialize(config)
        @api_key            = config[:api_key]
        @enabled_providers  = config[:enabled_providers] || []
        @disabled_providers = config[:disabled_providers] || []
      end
      
      def to_config
        {
          'APIKey'            => @api_key,
          'enabledProviders'  => @enabled_providers,
          'disabledProviders' => @disabled_providers,
        }
      end
      
    end
  end
end