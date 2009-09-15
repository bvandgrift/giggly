require 'test_helper'

class SocializeTest < Test::Unit::TestCase
  
  context "A Socialize Instance" do
    setup do
      @socialize = Giggly::Rest::Socialize.new(:api_key => 'fake', :secret_key => 'fake', :uid => 'fake')
    end
    
    should "disconnect the user" do
      FakeSocialize.setup_response(:disconnect, :success)
    end
    
  end
  
end