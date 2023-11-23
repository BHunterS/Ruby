module Printable
  def print_info
    puts "Information about the object:"
    instance_variables.each do |var|
      puts "#{var}: #{instance_variable_get(var)}"
    end
  end
end

class MyClass
  include Printable

  def initialize(name, age)
    @name = name
    @age = age
  end
end

# Create object
obj = MyClass.new("John", 30)

# Execute method print_info
obj.print_info
