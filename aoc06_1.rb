# https://adventofcode.com/2020/day/6

groups = File.open('aoc06_input.txt').read.split("\n\n")

answers = groups.reduce(0) do |sum, group|
  sum + group.gsub("\n", '').chars.uniq.count
end

p answers
