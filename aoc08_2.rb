# https://adventofcode.com/2020/day/8, game console code

def run(program)
  pos = 0
  acc = 0
  counters = Array.new(program.length, 0)

  loop do
    return acc if pos >= program.length

    counters[pos] += 1
    return false if counters[pos] >= 2

    instruction, operand = program[pos].split
    case instruction
    when 'jmp'
      pos += operand.to_i
      next
    when 'acc'
      acc += operand.to_i
    end
    pos += 1
  end
end

data = File.open('aoc08_input.txt').read.lines(chomp: true) # can split here once
candidates = data.each_index.select { |i| data[i].match?(/jmp|nop/) }

result = candidates.detect do |i|
  program = data.dup.map(&:dup) # how about we don't copy the whole array but just replace one element?
  program[i].include?('jmp') ? program[i].sub!('jmp', 'nop') : program[i].sub!('nop', 'jmp')

  result = run(program)
  break result if result
end

p result
