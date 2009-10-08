require 'test_helper'

class Giggly::UserTest < Test::Unit::TestCase
  
  context "A Giggly::User instance" do
    
    setup do
      setup_giggly_rest
      FakeSocialize.setup_response(:user_info, :success)
      @user = @giggly.user_info
    end
    
    should "have data" do
      @user.data.should_not be_nil
    end
    
    should "have a user_id" do
      @user.user_id.should_not be_nil
      @user.user_id.should == '000000'
    end
    
    should "allow access to top level items in the data hash via method calls" do
      @user.should_not respond_to(:nickname)
      @user.nickname.should == 'Bobo'
      @user.data['nickname'].should == 'Bobo'
    end
    
  end
  
end