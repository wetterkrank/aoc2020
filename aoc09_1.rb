# https://adventofcode.com/2020/day/9, XMAS cypher

BLOCK = 25

file = File.open('aoc09_input.txt')
data = file.readlines.map { |x| x.chomp.to_i }

outlier = data[BLOCK..-1].find.with_index(BLOCK) do |x, i|
  data[i - BLOCK..i - 1].combination(2).none? { |combo| x == combo.sum }
end

p outlier
