class Rect
  attr_accessor :x, :y, :w, :h

  def initialize(x, y, w, h)
    @x = x
    @y = y
    @w = w
    @h = h
  end

  def self.copy(rect)
    new(rect.x, rect.y, rect.w, rect.h)
  end

  def to_s
    "( #{@x} #{@y} #{@w} #{@h} )"
  end
end

def get_possible_areas(n)
    factors = []

    (1..n).each do |i|
        if n % i == 0
            factors << [i, n / i]
        end
    end

    return factors
end

def get_positions(matrix)
  array = []

  (0...matrix.length).each do |i|
    (0...matrix[0].length).each do |j|
      if matrix[i][j] == 1
        array << [i, j]
      end
    end
  end

  return array
end

def convert_string_to_matrix(s)
    lines = s.split(/\r?\n/)
    matrix = Array.new(lines.length) { Array.new(lines[0].length, 0) }

    lines.each_with_index do |line, i|
        line.chars.each_with_index do |char, j|
            if char == '.'
                matrix[i][j] = 0
            elsif char == 'о'
                matrix[i][j] = 1
            end
        end
    end

    return matrix
end

def in_container(rect)
  rect.x + (rect.w - 1) < $cols && rect.x >= 0 &&
    rect.y + (rect.h - 1) < $rows && rect.y >= 0
end

def has_only_one_position(rect)
  $count = 0

  $positions.each_with_index do |pos, i|
    x = pos[1]
    y = pos[0]

    if x >= rect.x && x < rect.x + rect.w && y >= rect.y && y < rect.y + rect.h
      $count += 1
      $global = i
    end
  end

  $count == 1
end

def fill_all_variants(rect)
  (0...$rows).each do |i|
    break unless in_container(rect)
    
    (0...$cols).each do |j|
      break unless in_container(rect)

      unless has_only_one_position(rect)
        rect.x += 1
        next
      end

      $all_variants[$global].push(Rect.copy(rect))
      rect.x += 1
    end

    rect.x = 0
    rect.y += 1
  end
end

def not_overlapped?(current_array, rect)
  current_array.none? { |current| rectangles_overlapped?(current, rect) }
end

def rectangles_overlapped?(rect1, rect2)
  x_overlap = (rect1.x + rect1.w > rect2.x) && (rect2.x + rect2.w > rect1.x)
  y_overlap = (rect1.y + rect1.h > rect2.y) && (rect2.y + rect2.h > rect1.y)

  x_overlap && y_overlap
end

def generate_combinations(array, depth)
  if depth == $positions.size
    $answer << array.dup
    return
  end

  current_array = array.dup

  (0...$all_variants_lengths[depth]).each do |i|
    if not_overlapped?(current_array, $all_variants[depth][i])
      current_array << $all_variants[depth][i]
      generate_combinations(current_array, depth + 1)
      current_array = array.dup
    end
  end
end

def draw_rectangle(rect, position)
  rectangle = ""

  (rect.y...rect.h + rect.y).each do |i|
    (rect.x...rect.w + rect.x).each do |j|
      if position[0] == i && position[1] == j
        rectangle << 'о'
      else
        rectangle << '.'
      end
    end
    rectangle << "\n"
  end

  rectangle
end

def get_pieces()
  # Get all variants of rect in each point
  $areas.each { |area| fill_all_variants(Rect.new(0, 0, area[0], area[1])) }

  # Find a length of each list in all variants and add it to array
  $positions.size.times { |i| $all_variants_lengths[i] = $all_variants[i].size }

  # Generate answer
  generate_combinations([], 0)

  # Check all combinations
  # $answer.each do |rectangles|
  #   matrix = Array.new($rows) { Array.new($cols, 0) }

  #   rectangles.each do |rect|
  #     matrix = fill_matrix_with_rect(matrix, rect)
  #   end

  #   $positions.each do |position|
  #     matrix[position[0]][position[1]] = 0
  #   end

  #   $count = 0
  #   print_matrix(matrix)
  #   puts ""
  # end

  # Find max length of first element
  max_index = -1
  max_width = -1
  $answer.each_with_index do |rectangles, i|
    current_width = rectangles[0].x + rectangles[0].w
    if current_width > max_width
      max_width = current_width
      max_index = i
    end
  end

  # Convert list of rectangles to string rectangles with izym
  result = []
  current = $answer[max_index]

  $positions.each_with_index do |position, i|
    result[i] = draw_rectangle(current[i], position)
  end

  return result
end

# For tests
def fill_matrix_with_rect(matrix, rect)
  result = Array.new(matrix.length) { Array.new(matrix[0].length, 0) }

  (0...matrix.length).each do |i|
    (0...matrix[0].length).each do |j|
      if j < rect.x + rect.w && j >= rect.x && i >= rect.y && i < rect.y + rect.h
        result[i][j] = $count
      else
        result[i][j] = matrix[i][j]
      end
    end
  end

  $count += 1
  result
end

# For tests
def print_matrix(matrix)
    matrix.each do |row|
        row.each do |element|
            if element != -1
                print "#{element} "
            end
        end

        puts ""
    end
end

$cake1 = <<~CAKE1
........
..о.....
...о....
........
CAKE1

$cake2 = <<~CAKE2
.о......
......о.
....о...
..о.....
CAKE2

$cake3 = <<~CAKE3
.о.о....
........
....о...
........
.....о..
........
CAKE3

$matrix = convert_string_to_matrix($cake3)
$rows = $matrix.size
$cols = $matrix[0].size

$positions = get_positions($matrix)

if ($rows * $cols / $positions.length).is_a?(Integer)
  $areas = get_possible_areas($rows * $cols / $positions.length)

  $all_variants = Array.new($positions.size) { [] }
  $all_variants_lengths = Array.new($positions.size, 0)

  $global = 0
  $count = 1

  $answer = []

  pieces = get_pieces

  pieces.each do |piece|
    puts piece
    puts ""
  end
end