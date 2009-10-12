require 'rubygems'

gem 'ruby-hmac', '0.3.2'
gem 'httparty', '0.4.5'

require 'httparty'
require 'hmac-sha1'

# breaks the gigya web api down into idiomatic ruby for your coding pleasure.
module Giggly
  
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'giggly', 'rest')
require File.join(directory, 'giggly', 'javascript')
require File.join(directory, 'giggly', 'user')
require File.join(directory, 'giggly', 'friend')
require File.join(directory, 'giggly', 'session_info')

