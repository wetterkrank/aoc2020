# https://adventofcode.com/2020/day/6

groups = File.open('aoc06_input.txt').read.split("\n\n")

count = groups.reduce(0) do |sum, group|
  ppl = group.split("\n").count
  answers = group.gsub("\n", '').chars
  sum + answers.filter { |answer| answers.count(answer) == ppl }.uniq.count
end

p count
