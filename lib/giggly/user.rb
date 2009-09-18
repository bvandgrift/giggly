module Giggly
  class User
    
    attr_reader :data
    
    def new(data)
      @data = data
    end

    def user_id
      @data["UID"]
    end

    def [](value) 
      @data[value.to_s]
    end

  end
end
