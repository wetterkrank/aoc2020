# https://adventofcode.com/2020/day/24, hex tiles

CALC = { 'ne' => [-1, 1], 'e' => [0, 2], 'se' => [1, 1], 'sw' => [1, -1], 'w' => [0, -2], 'nw' => [-1, -1] }.freeze

def target(line)
  arr = line.chars.chunk_while { |a, _| %w[s n].include? a }.map(&:join)
  arr.reduce([0, 0]) { |coords, cmd| [coords[0] + CALC[cmd][0], coords[1] + CALC[cmd][1]] }
end

def adjacent_black(tile, floor)
  CALC.values.count { |y, x| floor[[tile[0] + y, tile[1] + x]] == false }
end

def expand(floor)
  floor.keys.each_with_object(floor.clone) do |tile, newfloor|
    CALC.values.each do |y, x|
      coords = [tile[0] + y, tile[1] + x]
      newfloor[coords] = newfloor[coords].nil? ? true : newfloor[coords]
    end
  end
end

def flip_all(floor)
  floor.each_with_object({}) do |(coords, white), newfloor|
    ab = adjacent_black(coords, floor)
    newfloor[coords] = if white
                         ab == 2 ? !floor[coords] : floor[coords]
                       else
                         ab.zero? || ab > 2 ? !floor[coords] : floor[coords]
                       end
  end
end

def place_tiles(data)
  data.each_with_object({}) { |cmd, floor| floor[target(cmd)] = floor[target(cmd)].nil? ? false : !floor[target(cmd)] }
end

data = File.open('aoc24_input.txt').read.lines(chomp: true)
floor = place_tiles(data)
100.times do |i|
  floor = expand(floor)
  floor = flip_all(floor)
  puts "#{i + 1}: #{floor.values.count(false)}"
end
