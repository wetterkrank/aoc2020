# https://adventofcode.com/2020/day/20, jigsaw puzzle

def to_num(str)
  out = []
  out << str.gsub('#', '1').gsub('.', '0').to_i(2)
  out << str.gsub('#', '1').gsub('.', '0').reverse.to_i(2)
end

def get_tiles(raw)
  raw = raw.split("\n\n").map { |t| t.lines(chomp: true) }
  raw.each_with_object(Hash.new) do |lines, obj|
    id = lines.shift.split.last[0..-1].to_i
    sides = []
    sides << to_num(lines.first)
    sides << to_num(lines.map { |ln| ln[-1] }.join)
    sides << to_num(lines.last)
    sides << to_num(lines.map { |ln| ln[0] }.join)
    obj[id] = sides
  end
end

def find_corners(tiles)
  tiles.select do |id, sides|
    others = tiles.reject { |k| k == id }.values.flatten(1)
    sides.count { |one| others.find { |another| (one & another != []) } } == 2
  end
end

data = File.open('aoc20_input.txt').read
tiles = get_tiles(data)
corners = find_corners(tiles)

puts corners.keys.reduce(:*)
