require 'forwardable'
require 'rubygems'

gem 'httparty', '0.4.3'
require 'httparty'

# breaks the gigya web api down into idiomatic ruby for your coding pleasure.
module Giggly
  
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'giggly', 'rest')

