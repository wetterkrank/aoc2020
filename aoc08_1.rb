# https://adventofcode.com/2020/day/8, game console code

data = File.open('aoc08_input.txt').read.lines(chomp: true)
pos = 0
acc = 0
counters = Array.new(data.length, 0)

loop do
  instruction, operand = data[pos].split
  counters[pos] += 1
  break if counters[pos] >= 2

  case instruction
  when 'jmp'
    pos += operand.to_i
    next
  when 'acc'
    acc += operand.to_i
  end

  pos += 1
  break if pos >= data.length
end

puts acc
