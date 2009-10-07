require 'test_helper'

class SocializeTest < Test::Unit::TestCase
  
  context "A Giggly::Rest::Socialize Instance" do
    setup do
      @request = Giggly::Rest::Request.new(
        :api_key => 'TEST_KEY',
        :secret_key => 'SECRET_KEY',
        :user_id    => 'GIGYA_USER_ID'
      )
      @giggly = Giggly::Rest::Socialize.new(@request)
    end
    
    should "disconnect the user" do
      FakeSocialize.setup_response(:disconnect, :success)
      response = @giggly.disconnect
      response.should be_successful
    end
    
    should "get friends info and return array of Giggly::Friend objects" do
      FakeSocialize.setup_response(:friends_info, :success)
      friends = @giggly.friends_info
      assert friends.size > 0
      friends.each do |friend|
        friend.class.should == Giggly::Friend
      end
    end
    
    should "get raw data and return it as a string" do
      FakeSocialize.setup_response(:raw_data, :success)
      response = @giggly.raw_data('facebook', %w[birthday name])
      response.should be_successful
      response['data'].should == '[{"birthday":"May 31, 1972","name":"Bobo"}]'
    end
    
    should "get the session info for the current gigya connection" do
      FakeSocialize.setup_response(:session_info, :success)
      session_info = @giggly.session_info('facebook')
      session_info.class.should == Giggly::SessionInfo
      session_info.session.should_not be_nil
    end
    
    should "get the user's info as a user object" do
      FakeSocialize.setup_response(:user_info, :success)
      user = @giggly.user_info
      user.class.should == Giggly::User
    end
    
    should "published the user action" do
      FakeSocialize.setup_response(:publish_user_action, :success)
      response = @giggly.publish_user_action 'this would be valid xml in real life ^_^'
      response.should be_successful
    end
    
    should "send notification to users friends" do
      FakeSocialize.setup_response(:send_notification, :success)
      response = @giggly.send_notification %w[_gigya_uid1 _gigya_uid2], 'this is a test', 'this is only a test'
      response.should be_successful
    end
    
    should "set the users status" do
      #FakeSocialize.setup_response(:status=, :success)
      #@giggly.status=('the giggly gem is so awesome!')
      #response.should be_successful
    end
    
    # should "raise an exception if an invalid provider is given" do
    #   FakeSocialize.setup_response(:status=, :success) # just incase of failure
    #   lambda {@giggly.status = 'Fail! #ftw', {:enabled_providers => %w[twitter google]}}.should raise_error(Giggly::Rest::Socialize::InvalidProvider)
    # end

    should "throw an exception on failure" do
      FakeSocialize.setup_response(:disconnect, :failure)
      lambda {@giggly.disconnect}.should raise_error(Giggly::Rest::Unauthorized)
    end
    
  end
  
end