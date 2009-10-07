require 'test_helper'

class Giggly::Rest::RequestTest < Test::Unit::TestCase
  
  context "A Giggly::Rest::Request instance" do
    setup do
      @request = Giggly::Rest::Request.new(
        :api_key => 'TEST_KEY',
        :secret_key => 'SECRET_KEY',
        :user_id    => 'GIGYA_USER_ID'
      )
    end
    
    # this is a sanity check for the signature method
    # the signature is the test was generated using the signature method which we know
    # currently works with gigya, see http://twitter.com/_ah/status/4567114726
    # which was posted from irb using Giggly
    should "create a valid signature" do
      Time.stubs(:now).returns(1254940826)
      params = @request.sign('POST', "#{Giggly::Rest::Socialize::GIGYA_URL}getUserInfo", {})
      'olilJCSJzaBmzb9tsHH8LmJpYp0='.should == params['sig']
    end
    
  end
  
end