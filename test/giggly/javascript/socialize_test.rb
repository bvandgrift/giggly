require 'test_helper'

class Giggly::Javascript::SocializeTest < Test::Unit::TestCase
  
  context "A Giggly::Javascript::Socialize instance" do
    
    setup do
      @giggly = Giggly::Javascript::Socialize.new(:api_key => 'API_KEY', :enabled_providers => %w[facebook yahoo twitter])
    end
    
    should "should have a config hash with no nil values" do
      @giggly.to_config.should == {'APIKey' => 'API_KEY', 'enabledProviders'  => 'facebook,yahoo,twitter'}
    end
    
    should "return the config as a string for javascript" do
      @giggly.config_to_js.class.should == String
      @giggly.config_to_js.should =~ /APIKey/
      @giggly.config_to_js.should =~ /enabledProviders/
    end
    
    should "return a script tag with the path to the giggly socialize js api file" do
      @giggly.include_gigya_socialize =~ /giggly-socialize-min/
    end
    
    should "allow a custom path to the giggly socialize api file" do
      @giggly.include_gigya_socialize('/somewhere') =~ /somewhere/
    end
    
    should "require the non minified giggly socialize api file if min is false" do
      @giggly.include_gigya_socialize('/javascripts', false).should_not =~ /min\.js/
    end
    
  end
  
end