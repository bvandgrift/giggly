module Giggly
  module Javascript
    class Socialize
      include Giggly::Javascript::Helper
      
      attr_accessor :api_key, :enabled_providers, :disabled_providers, :config
      
      def initialize(config)
        @api_key            = config[:api_key]
        @enabled_providers  = array_to_string(config[:enabled_providers])
        @disabled_providers = array_to_string(config[:disabled_providers])
        
        @config = to_config
      end
      
      def to_config
        {
          'APIKey'            => @api_key,
          'enabledProviders'  => @enabled_providers,
          'disabledProviders' => @disabled_providers
        }.reject { |k,v| v.nil? }
      end
      
      # Socialize specific JS methods
      
      def config_to_js(config_var_name = :gigyaConfig)
        to_var(config_var_name, to_config)
      end
      
      def include_gigya_socialize(js_path = '/javascripts')
        include_gigya_api(:socialize) + "\n<script type=\"text/javascript\" src=\"#{js_path}/giggly-socialize.js\"></script>"
      end
      
      protected 
      
        def array_to_string(array)
          if array.is_a? String
            array
          elsif array.is_a? Array
            array.join(',')
          end
        end
      
    end
  end
end