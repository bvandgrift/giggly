module Giggly
  
end

# version 1
#
# @@config = {}
# 
# class << self
#   def config 
#     @@config
#   end
#   def load_configuration(config_file)
#     @@config = YAML.load_file(config_file)[RAILS_ENV]
#     puts "GIGYA CONFIG:\n" + Giggly.config.inspect
#   end
#   
#   def signature(token, value)
#      base_string = "#{token}_#{value}"
#      binary_key = Base64.decode64(Giggly.config["APIKey"])
#      unencoded_signature = HMAC::SHA1.digest(binary_key, base_string)
#      Base64.encode64(unencoded_signature)
#   end
#   
#   def validate_signature(token, value, sig)
#     sig == signature(token, value) 
#   end
# end