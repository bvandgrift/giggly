require 'test_helper'

class Giggly::FriendTest < Test::Unit::TestCase
  
  context "A Giggly::Friend instance" do
    
    setup do
      setup_giggly_rest
      FakeSocialize.setup_response(:friends_info, :success)
      @friends = @giggly.friends_info
      @friend = @friends.first
    end
    
    # this is overtesting
    should "inherit from user" do
      @friend.kind_of? Giggly::Friend
      @friend.kind_of? Giggly::User
      @friend.class.superclass.should == Giggly::User
    end
    
  end
  
end