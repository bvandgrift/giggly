module Giggly
  class User
    attr_reader :user_data
    def new(data)
      @user_data = data
    end

    def user_id
      @user_data["UID"]
    end

    def [](value) 
      @user_data[value.to_s]
    end

  end
end
