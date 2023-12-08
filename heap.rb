class Heap
  attr_accessor :heap

  def initialize
    @heap = []
  end

  def heapify(arr)
    @heap = arr
    (arr.size / 2 - 1).downto(0) do |i|
      heapify_down(i)
    end
  end

  def insert(value)
    @heap.push(value)
    heapify_up(@heap.size - 1)
  end

  def extract_root
    return nil if @heap.empty?

    max_value = @heap[0]
    last_value = @heap.pop

    unless @heap.empty?
      @heap[0] = last_value
      heapify_down(0)
    end

    max_value
  end

  def peek
    @heap.empty? ? nil : @heap[0]
  end

  def print_tree
    print_tree_recursive(0, 0)
  end

  def compare(a, b)
    raise NotImplementedError, "compare method must be implemented in subclasses"
  end

  private

  def heapify_up(current_index)
    while current_index > 0
      parent_index = (current_index - 1) / 2

      break if compare_up(@heap[parent_index], @heap[current_index])

      # Swap with parent if the current value is greater
      @heap[parent_index], @heap[current_index] = @heap[current_index], @heap[parent_index]

      current_index = parent_index
    end
  end

  def heapify_down(current_index)
    while true
      left_child_index = 2 * current_index + 1
      right_child_index = 2 * current_index + 2
      cur = current_index

      if left_child_index < @heap.size && compare_down(@heap[left_child_index], @heap[cur])
        cur = left_child_index
      end

      if right_child_index < @heap.size && compare_down(@heap[right_child_index], @heap[cur])
        cur = right_child_index
      end

      break if cur == current_index

      # Swap with the smaller child
      @heap[current_index], @heap[cur] = @heap[cur], @heap[current_index]

      current_index = cur
    end
  end

  def print_tree_recursive(index, level)
    return if index >= @heap.size

    print_tree_recursive(2 * index + 2, level + 1) # right child
    puts ' ' * 4 * level + "#{@heap[index]}"
    print_tree_recursive(2 * index + 1, level + 1) # left child
  end
end

class MaxHeap < Heap
  def compare_up(a, b)
    a >= b
  end
  
  def compare_down(a, b)
    a > b
  end
end

class MinHeap < Heap
  def compare_up(a, b)
    a <= b
  end

  def compare_down(a, b)
    a < b
  end
end

array = [5, 12, 8, 3, 15, 7]

max_heap = MaxHeap.new
max_heap.heapify(array.dup)

puts "======================================="

puts "Max-heap Tree(start):"
max_heap.print_tree

max_heap.insert(10)

puts "Max-heap Tree(insert 10):"
max_heap.print_tree

max_value = max_heap.extract_root
puts "Extracted Max Value: #{max_value}"

puts "Max-heap Tree(extracted value):"
max_heap.print_tree

top_value = max_heap.peek
puts "Top Value: #{top_value}"

puts "Max-heap Tree(peek value):"
max_heap.print_tree

puts "======================================="

min_heap = MinHeap.new
min_heap.heapify(array.dup)

puts "======================================="

puts "Min-heap Tree(start):"
min_heap.print_tree

min_heap.insert(10)

puts "Min-heap Tree(insert 10):"
min_heap.print_tree

min_value = min_heap.extract_root
puts "Extracted Min Value: #{min_value}"

puts "Min-heap Tree(extracted value):"
min_heap.print_tree

top_value = min_heap.peek
puts "Top Value: #{top_value}"

puts "Min-heap Tree(peek value):"
min_heap.print_tree

puts "======================================="