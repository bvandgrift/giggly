require 'test_helper'
require 'hmac-sha1'
require 'base64'

class RestTest < Test::Unit::TestCase
  
  context "The Rest Module" do
    setup do
      @valid_hash = Base64.encode64 HMAC::SHA1.hexdigest(Base64.decode64("TEST_KEY"),"TEST_PATTERN")      
    end
    
    should "create an SHA1 hash" do
      assert_nothing_thrown do
        assert_equal @valid_hash, Giggly::Rest::signature("TEST_KEY", "TEST", "PATTERN")
      end
    end
    
    should "test a signature for sanity" do
      assert_nothing_thrown do
        assert @valid_hash, Giggly::Rest::validate_signature("TEST_KEY", "TEST", "PATTERN", @valid_signature)
      end
      
    end
    
    should "use real live data!" do
      flunk "PROBLEM: we haven't checked this against gigya yet."
    end
    
  end
  
end