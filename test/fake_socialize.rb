require 'fakeweb'
require 'yaml'

# sets up a socialize faker.
#
# example::
# <tt>
# FakeSocialize.setup_response("disconnect", :success)
# </tt>
class FakeSocialize
  
  @@responses = nil
  
  def self.initialize
    reload_responses unless @@responses
  end

  def self.setup_response(method_ref, response_name)
    response = @@responses[method_ref]
    FakeWeb.register_uri(
      response[:request_type], 
      Giggly::Rest::Socialize::GIGYA_URL + response[:method_name], 
      :body => response[response_name]
    )
  end

  private
  
  def self.reload_responses
    # We'll need to figure this next bit out
    @@responses = {}
    Dir.new(File.join(File.dirname(__FILE__), 'responses')).each do |filename|
      @@responses.merge!(YAML.load(File.read(filename))) if File.file?(filename) 
    end 
  end
  
  
end

