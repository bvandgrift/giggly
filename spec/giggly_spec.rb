require File.dirname(__FILE__) + '/spec_helper'
require 'hmac-sha1'

puts "GIGGLY TESTING"

describe Giggly do
  before do
    @default_token = "TOKEN"
    @default_guid = "GUID"
    @test_key = "TESTKEY"
    @default_signature = create_signature(@default_token, @default_guid, @test_key)
  end

  it "should correctly create a signature" do
     Giggly.signature("TOKEN", "GUID").should == @default_signature
  end
  
  it "should validate signatures correctly" do
    Giggly.validate_signature("TOKEN", "GUID", @default_signature).should be_true
    Giggly.validate_signature("WRONG", "GUID", @default_signature).should be_false    
  end

  private
    def create_signature(token, value, key)
      base_string = "#{token}_#{value}"
      binary_key = Base64.decode64(key)
      unencoded_signature = HMAC::SHA1.digest(binary_key, base_string)
      Base64.encode64(unencoded_signature)
    end

end