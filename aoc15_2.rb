# https://adventofcode.com/2020/day/15, elves' game of memory

def next_number(last, memory)
  memory[last][1] ? memory[last][0] - memory[last][1] : 0
end

data = [12, 20, 0, 6, 1, 17, 7]
# data = [0, 3, 6] # test

memory = {}
num = nil

(1..30_000_000).each do |turn|
  num = data[turn - 1] || next_number(num, memory)
  memory[num] ||= [nil, nil]
  memory[num][1] = memory[num][0]
  memory[num][0] = turn
end

puts num
