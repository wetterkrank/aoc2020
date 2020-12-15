# https://adventofcode.com/2020/day/9, XMAS cypher

BLOCK = 25

file = File.open('aoc09_input.txt')
data = file.readlines.map { |x| x.chomp.to_i }

outlier_index = BLOCK + data[BLOCK..-1].find_index.with_index(BLOCK) do |x, i|
  data[i - BLOCK..i - 1].combination(2).none? { |combo| x == combo.sum }
end
outlier = data[outlier_index]

result = (2..BLOCK).find do |set_size|
  search_range = (0..outlier_index - set_size)
  found_set_start = search_range.find { |i| data[i, set_size].sum == outlier }
  break data[found_set_start, set_size] if found_set_start
end

p result&.minmax&.reduce(:+)
