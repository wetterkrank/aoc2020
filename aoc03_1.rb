# https://adventofcode.com/2020/day/3

hits = 0

File.foreach('aoc03_input.txt').with_index do |line, i|
  terrain = line.chomp.gsub('.', '0').gsub('#', '1').reverse.to_i(2)
  toboggan = (i * 3) % 31
  hits += (2**toboggan & terrain).positive? ? 1 : 0
end

puts hits
