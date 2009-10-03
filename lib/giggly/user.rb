module Giggly
  class User
    
    attr_reader :data
    
    def initialize(data)
      @data = data
    end

    def user_id
      @data["UID"]
    end

    def [](value) 
      @data[value.to_s]
    end
    
    def method_missing(method, *args)
      super unless @data[method.to_s]
      @data[method.to_s]
    end

  end
end
