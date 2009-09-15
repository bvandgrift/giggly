reqiure 'digest'

module Giggly
  module Rest
    
    def self.signature(token, value)
      base_string = "#{token}_#{value}"
      binary_key = Base64.decode64(Giggly.config["APIKey"])
      unencoded_signature = Digest::SHA1.hexdigest(binary_key, base_string)
      Base64.encode64(unencoded_signature)
    end

    def self.validate_signature(token, value, sig)
      sig == signature(token, value) 
    end
    
  end
end