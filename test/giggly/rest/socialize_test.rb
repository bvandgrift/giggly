require 'test_helper'

class Giggly::Rest::SocializeTest < Test::Unit::TestCase
  
  context "A Giggly::Rest::Socialize Instance" do
    setup do
      setup_giggly_rest
    end
    
    should "disconnect the user" do
      FakeSocialize.setup_response(:disconnect, :success)
      response = @giggly.disconnect
      response.should be_successful
    end
    
    should "get friends info and return array of Giggly::Friend objects" do
      FakeSocialize.setup_response(:friends_info, :success)
      friends = @giggly.friends_info
      friends.size.should > 0
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
    
    should "set the users status via set_status" do
      FakeSocialize.setup_response(:status=, :success)
      response = @giggly.set_status 'the giggly gem is so awesome!', :enabled_providers => %w[facebook twitter]
      response.should be_successful
    end
    
    should "set the users status via status=" do
      FakeSocialize.setup_response(:status=, :success)
      status = 'the giggly gem is so awesome!'
      response = @giggly.status = status
      response.class.should == String
      response.should == status
    end
    
    should "raise an exception on failing to set the user's status in status=" do
      FakeSocialize.setup_response(:status=, :failure)
      lambda {@giggly.status = 'the giggly gem is so awesome!'}.should raise_error(Giggly::Rest::Unauthorized)
    end
    
    should "raise an exception if an invalid provider is given" do
      FakeSocialize.setup_response(:status=, :success) # just incase of failure
      fail = lambda {@giggly.set_status 'Fail! #ftw', :enabled_providers => %w[twitter google]}
      fail.should raise_error(Giggly::Rest::Socialize::InvalidProvider)
    end
    
    should "throw an exception on failure" do
      FakeSocialize.setup_response(:disconnect, :failure)
      lambda {@giggly.disconnect}.should raise_error(Giggly::Rest::Unauthorized)
    end
    
    should "send notification to users friends" do
      FakeSocialize.setup_response(:send_notification, :success)
      response = @giggly.send_notification %w[_gigya_uid1 _gigya_uid2], 'this is a test', 'this is only a test'
      response.should be_successful
    end
    
  end
  
end