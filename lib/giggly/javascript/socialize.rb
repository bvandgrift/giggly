module Gigya
  module Javascript
    class Socialize
      include Gigya::Javascript::Helper
      
      attr_accessor :api_key, :enabled_providers, :disabled_providers, :config
      
      def initialize(config)
        @api_key            = config[:api_key]
        @enabled_providers  = config[:enabled_providers] || []
        @disabled_providers = config[:disabled_providers] || []
        
        @config = to_config
      end
      
      def to_config
        {
          'APIKey'            => @api_key,
          'enabledProviders'  => @enabled_providers,
          'disabledProviders' => @disabled_providers,
        }
      end
      
      # Socialize specific JS methods
      
      def config_to_js(config_var_name = 'gigya_config')
        to_var(config_var_name, to_config)
      end
      
      def include_gigya_socialize
        include_gigya_api 'socialize'
      end
      
    end
  end
end