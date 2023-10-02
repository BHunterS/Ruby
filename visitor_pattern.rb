class Component
  def accept(_visitor)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteComponentA < Component
  def accept(visitor)
    visitor.visit_concrete_component_a(self)
  end

  def exclusive_method_of_concrete_component_a
    'A'
  end
end

class ConcreteComponentB < Component
  def accept(visitor)
    visitor.visit_concrete_component_b(self)
  end

  def special_method_of_concrete_component_b
    'B'
  end
end

class Visitor
  def visit_concrete_component_a(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def visit_concrete_component_b(_element)
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class ConcreteVisitor1 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

class ConcreteVisitor2 < Visitor
  def visit_concrete_component_a(element)
    puts "#{element.exclusive_method_of_concrete_component_a} + #{self.class}"
  end

  def visit_concrete_component_b(element)
    puts "#{element.special_method_of_concrete_component_b} + #{self.class}"
  end
end

def client_code(components, visitor)
  # ...
  components.each do |component|
    component.accept(visitor)
  end
  # ...
end

components = [ConcreteComponentA.new, ConcreteComponentB.new]

puts 'The client code works with all visitors via the base Visitor interface:'
visitor1 = ConcreteVisitor1.new
client_code(components, visitor1)

puts 'It allows the same client code to work with different types of visitors:'
visitor2 = ConcreteVisitor2.new
client_code(components, visitor2)