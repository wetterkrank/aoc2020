# https://adventofcode.com/2020/day/3

hits = 0

File.foreach('aoc03_input.txt').with_index do |line, i|
  terrain = line.chomp
  toboggan = (i * 3) % terrain.length
  hits += 1 if terrain[toboggan] == '#'
end

puts hits
