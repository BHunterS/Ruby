class HuffmanNode
  attr_accessor :left, :right, :char, :frequency

  def initialize(char, frequency)
    @char = char
    @frequency = frequency
    @left = nil
    @right = nil
  end

  def leaf?
    left.nil? && right.nil?
  end
end

def build_huffman_tree(text)
  frequency_map = Hash.new(0)

  # Count frequency
  text.each_char { |char| frequency_map[char] += 1 }

  # Create priority queue
  priority_queue = frequency_map.map { |char, freq| HuffmanNode.new(char, freq) }
  priority_queue.sort_by! { |node| node.frequency }

  # Build huffman tree
  while priority_queue.length > 1
    left = priority_queue.shift
    right = priority_queue.shift
    parent = HuffmanNode.new(nil, left.frequency + right.frequency)
    parent.left = left
    parent.right = right
    priority_queue.push(parent)
    priority_queue.sort_by! { |node| node.frequency }
  end

  priority_queue.first
end

def build_huffman_codes(node, current_code = '', codes = {})
  if node.leaf?
    codes[node.char] = current_code
  end

  build_huffman_codes(node.left, current_code + '0', codes) if node.left
  build_huffman_codes(node.right, current_code + '1', codes) if node.right

  codes
end

def huffman_encode(text, root, codes)
  text.each_char.map { |char| codes[char] }.join
end

def huffman_decode(encoded_text, root)
  decoded_text = ''
  current_node = root

  encoded_text.each_char do |bit|
    if bit == '0'
      current_node = current_node.left
    else
      current_node = current_node.right
    end

    if current_node.leaf?
      decoded_text += current_node.char
      current_node = root
    end
  end

  decoded_text
end

text = "Example code of huffman algorithm."

if text.length > 1
  tree = build_huffman_tree(text)
  codes = build_huffman_codes(tree)

  if codes.length > 1
    encoded_text = huffman_encode(text, tree, codes)
    puts "Encoded Text: #{encoded_text}"

    decoded_text = huffman_decode(encoded_text, tree)
    puts "Decoded Text: #{decoded_text}"
  else
    puts "Error: only one symbol in string!"
  end
else
  puts "Error: empty string!"
end
