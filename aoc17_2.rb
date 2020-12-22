# https://adventofcode.com/2020/day/17, Conway's Life in 4D

DIRS = [-1, 0, 1].repeated_permutation(4).to_a - [[0, 0, 0, 0]]

def empty_hash
  Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = {} } } }
end

# automatic empty hash insertion? easy!
def load(data)
  space = empty_hash
  data.each_with_index do |row, y|
    row.each_with_index do |ch, x|
      space[0][0][y][x] = true if ch == '#'
    end
  end
  space
end

# hello recursive hash traversal with a block
def walk(object, parent = nil, grandp = [], &block)
  object.each do |key, value|
    if value.is_a? Hash
      grandp.prepend(parent)
      grandp = grandp.slice(0, 2) # 2 most recent parent keys to keep
      walk(value, key, grandp, &block)
    else
      yield(grandp[1], grandp[0], parent, key, value) if block_given?
    end
  end
end

# let's calculate (min - 1) and (max + 1) for every axis
def build_box(hash)
  dims = [[], [], [], []]
  walk(hash) do |w, z, y, x, _|
    dims[0] << w
    dims[1] << z
    dims[2] << y
    dims[3] << x
  end
  dims = dims.map(&:minmax).map { |axis| [axis[0] - 1, axis[1] + 1] }
  (dims[0][0]..dims[0][1]).to_a.product((dims[1][0]..dims[1][1]).to_a, (dims[2][0]..dims[2][1]).to_a, (dims[3][0]..dims[3][1]).to_a)
end

def count_neigbours(hash, w, z, y, x)
  DIRS.reduce(0) { |cnt, d| hash.dig(w + d[0], z + d[1], y + d[2], x + d[3]).nil? ? cnt : cnt + 1 }
end

def cycle(hash)
  boxed_cubes = build_box(hash)
  shadow = empty_hash

  boxed_cubes.each do |(w, z, y, x)|
    neigbours = count_neigbours(hash, w, z, y, x)
    if hash.dig(w, z, y, x)
      shadow[w][z][y][x] = true if (2..3).cover? neigbours
    elsif neigbours == 3
      shadow[w][z][y][x] = true
    end
  end
  shadow
end

data = File.open('aoc17_input.txt').read.lines(chomp: true).map(&:chars)
space = load(data)

6.times do
  space = cycle(space)
end

count = 0
walk(space) { count += 1 }
puts count
