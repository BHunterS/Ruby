class Shape
  def area
    raise NotImplementedError, "Subclasses must implement the area method"
  end
end

class Rectangle < Shape
  def initialize(width, height)
    @width = width
    @height = height
  end

  def area
    @width * @height
  end
end

class Square < Shape
  def initialize(side_length)
    @side_length = side_length
  end

  def area
    @side_length * @side_length
  end
end

# Коректне використання принципу підстановки Барбари Лісков
def print_area(shape)
  puts "Area: #{shape.area}"
end

rectangle = Rectangle.new(5, 10)
square = Square.new(4)

print_area(rectangle) # Виводить "Area: 50"
print_area(square)    # Виводить "Area: 16"
