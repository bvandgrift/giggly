module Gigya
  module Javscript
    module Helper
      
      # The Javascript helper should be totally generic to the api that is being used
      # So that if there is a future api it can be wrapped in a class and include this
      
      def include_gigya_api(service)
        '<script type="text/javascript" src="http://cdn.gigya.com/JS/gigya.js?services=' + service + '"></script>'
      end
      
      def javascript(&block)
        out = '<script type="text/javascript">'
        out += yield.to_s
        out += '</script>'
        out
      end
      
      def to_var(name, object, scope_to_window = false)
        "#{scope_to_window ? '' : 'var '}#{name} = #{javascriptify_object};"
      end
      
      # borrowed mainly from the ym4r_gm plugin
      def javascriptify_object(object)
        if object.is_a? String
          "'#{escape_javascript object}'"
        elsif object.is_a? Array
          '[' + object.collect { |o| javascriptify_variable(o) }.join(',') + ']'
        elsif object.is_a? Hash
          '{' + object.to_a.collect { |o| "#{o[0].to_s} : #{javascriptify_variable(o[1])}" }.join(',') + '}'
        elsif object.nil?
          'undefined'
        else
          object.to_s
        end
      end
      
      # from rails
      def escape_javascript(javascript)
        javascript.gsub(/\r\n|\n|\r/, "\\n").gsub("\"") { |m| "\\#{m}" }
      end
      
    end
  end
end