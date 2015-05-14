module Avalara
  class Error < StandardError       ; end
  class TimeoutError < Error        ; end
  class NotImplementedError < Error ; end

  class ApiError < Error
    attr_reader :object

    def initialize(object)
      @object = object
    end
  end
end