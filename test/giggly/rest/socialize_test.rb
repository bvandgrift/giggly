require 'test_helper'

class SocializeTest < Test::Unit::TestCase
  
  context "A Socialize Instance" do
    setup do
      @socialize = Giggly::Rest::Socialize.new(:api_key => 'fake', :secret_key => 'fake', :uid => 'fake')
    end
    
    should "disconnect the user" do
      fs = FakeSocialize.setup_response(:disconnect, :success)
      response = @socialize.disconnect
      assert_response_valid(response, fs)
    end

    should "fail throw an exception on failure" do
      fs = FakeSocialize.setup_response(:disconnect, :failure)
      assert_raise Giggly::Rest::Unauthorized do
        response = @socialize.disconnect 
      end
    end
    
  end
  
  def assert_response_valid(response, fake_config, checks = {"statusCode" => "200"})
    checks.each { |k,v| assert response[k] == v }
  end
  
end