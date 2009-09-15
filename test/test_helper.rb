require 'test/unit'
require 'rubygems'

gem 'thoughtbot-shoulda', '>= 2.10.1'
gem 'jnunemaker-matchy', '0.4.0'
gem 'mocha', '0.9.7'
gem 'fakeweb', '>= 1.2.5'

require 'shoulda'
require 'matchy'
require 'mocha'
require 'fakeweb'

dir = (Pathname(__FILE__).dirname + '../lib').expand_path
require dir + 'giggly'

require 'fake_socialize'

class Test::Unit::TestCase
end

