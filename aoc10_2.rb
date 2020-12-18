# https://adventofcode.com/2020/day/10, joltage adapters

data = File.open('aoc10_input.txt').readlines.map { |x| x.chomp.to_i }
data << 0
data << data.max + 3

groups = data.sort.chunk_while { |i, j| i + 1 == j }.map(&:size) # split graph into sections separated by gaps
combos = (3..groups.max).inject([0, 1, 1]) { |cmb, _| cmb << cmb[-3..-1].sum } # count combinations for each group size
paths = groups.map { |group| combos[group] }.reduce(:*) # multiply to calculate the total

p paths
