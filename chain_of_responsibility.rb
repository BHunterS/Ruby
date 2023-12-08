class BaseHandler
  attr_reader :successor

  def initialize(successor = nil)
    @successor = successor
  end

  def handle_request(request)
    if successor
      successor.handle_request(request)
    else
      puts "Request not handled."
    end
  end
end

class ConcreteHandler1 < BaseHandler
  def handle_request(request)
    if request == "condition1"
      puts "ConcreteHandler1 handles the request."
    else
      super(request)
    end
  end
end

class ConcreteHandler2 < BaseHandler
  def handle_request(request)
    if request == "condition2"
      puts "ConcreteHandler2 handles the request."
    else
      super(request)
    end
  end
end

handler1 = ConcreteHandler1.new
handler2 = ConcreteHandler2.new(handler1)

handler2.handle_request("condition1") # ConcreteHandler1 handles the request.
handler2.handle_request("condition2") # ConcreteHandler2 handles the request.
handler2.handle_request("condition3") # Request not handled.
