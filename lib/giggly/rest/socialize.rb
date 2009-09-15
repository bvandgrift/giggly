module Giggly
  module Rest
    class Socialize
      
      def initialize(connection)
        @connection = connection and return if connection.kind_of?(Giggly::Rest::Connection)
        @connection = Giggly::Rest::Connection.new(connection)
      end
      
    end
  end
end