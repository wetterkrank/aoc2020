# https://adventofcode.com/2020/day/17

DIRS = [-1, 0, 1].repeated_permutation(3).to_a - [[0, 0, 0]]

# automatic empty hash insertion?
def load(data)
  space = Hash.new { |hash, key| hash[key] = Hash.new { |hash, key| hash[key] = {} } }
  data.each_with_index do |row, y|
    row.each_with_index do |ch, x|
      space[0][y][x] = true if ch == '#'
    end
  end
  space
end

# hello recursive hash traversal with a block
def walk(object, parent = nil, grandp = nil, &block)
  object.each do |key, value|
    if value.is_a? Hash
      grandp = parent
      walk(value, key, grandp, &block)
    else
      yield(grandp, parent, key, value) if block_given?
    end
  end
end

# let's calculate (min - 1) and (max + 1) for every axis
def build_box(hash)
  dims = [[], [], []]
  walk(hash) do |z, y, x, _|
    dims[0] << z
    dims[1] << y
    dims[2] << x
  end
  dims.map!(&:minmax).map { |axis| [axis[0] - 1, axis[1] + 1] }
end

def count_neigbours(hash, z, y, x)
  DIRS.reduce(0) { |cnt, d| hash.dig(z + d[0], y + d[1], x + d[2]).nil? ? cnt : cnt + 1 }
end

def cycle(hash)
  box = build_box(hash)
  shadow = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = {} } }

  (box[0][0]..box[0][1]).each do |z|
    puts "z: #{z}"
    (box[1][0]..box[1][1]).each do |y|
      (box[2][0]..box[2][1]).each do |x|

        neigbours = count_neigbours(hash, z, y, x)
        if hash.dig(z, y, x)
          shadow[z][y][x] = true if (2..3).cover? neigbours
        elsif neigbours == 3
          shadow[z][y][x] = true
        end

        print shadow.dig(z, y, x) ? '#' : '.'
      end
      print "\n"
    end
    print "\n\n"
  end
  shadow
end

data = File.open('aoc17_input.txt').read.lines(chomp: true).map(&:chars)

# one way to go is an array and a movable 0 point
# zero = {z: 0, x: 0, y: 0}
# space = Array.new(1) { Array.new(3) {Array.new(3)} }
# but we'll use hash

space = load(data)

6.times do |i|
  puts "cycle #{i + 1}"
  space = cycle(space)
end

count = 0
walk(space) { count += 1 }
p count
