require 'test_helper'
require 'yaml'

# sets up a socialize faker.
#
# example::
# <tt>
# FakeSocialize.setup_response("disconnect", :success)
# </tt>
class FakeSocialize
  
  @@responses ||= {}
  
  # this appears to never get called.  might cut.
  def FakeSocialize.initialize
    puts "Initializing FakeSocialize."
    @@responses = reload_responses if @@responses.nil? || @@responses.empty?
  end

  def self.setup_response(method_ref, response_name)
    reload_responses if @@responses.nil? || @@responses.empty?
    response = @@responses[method_ref]
    FakeWeb.register_uri(
      response[:request_type], 
      Regexp.new(Giggly::Rest::Socialize::GIGYA_URL + response[:method_name]), 
      :body => response[response_name]
    )
    return response.merge({:response_key => "socialize.#{response[:method_name]}Response"})
  end
  
  def self.reload_responses
    responses = {}
    Dir.new(File.join(File.dirname(__FILE__), 'responses')).each do |filename|
      file_path = File.join(File.dirname(__FILE__), 'responses', filename)
      next unless File.file?(file_path)
      responses.merge!(YAML.load(File.read(file_path))) if File.file?(file_path) 
    end
    @@responses = responses 
  end
  
  
end

