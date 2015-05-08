module Avalara
  module Response
    class AddressPayload < Avalara::Types::Stash
      property :address,      from: :Address
      property :result_code,  from: :ResultCode
      property :messages,     from: :Messages

      def success?
        result_code == "Success"
      end

      def failure?
        result_code == "Error"
      end

      def Messages=(new_messages)
        self.messages = []
        new_messages.each do |message|
          self.messages << Message.new(message)
        end
      end

      def Address=(lines)
        self.address = []
        lines.each do |line|
          self.address << Address.new(line)
        end
      end
    end
  end
end
