# https://adventofcode.com/2020/day/1

file = File.open('aoc01_input.txt')
data = file.readlines.map { |x| x.chomp.to_i }

results = data.permutation(3).find { |p| p.sum == 2020 } # terrible but convenient
puts results.reduce(:*)
