# https://adventofcode.com/2020/day/24, hex tiles

CALC = { 'ne' => [-1, 1], 'e' => [0, 2], 'se' => [1, 1], 'sw' => [1, -1], 'w' => [0, -2], 'nw' => [-1, -1] }

def target(line)
  arr = line.chars.chunk_while { |a, _| %w[s n].include? a }.map(&:join)
  arr.reduce([0, 0]) { |coords, cmd| [coords[0] + CALC[cmd][0], coords[1] + CALC[cmd][1]] }
end

data = File.open('aoc24_input.txt').read.lines(chomp: true)
floor = Hash.new(true)

data.each { |tile| floor[target(tile)] = !floor[target(tile)] }

puts floor.values.count(false)
