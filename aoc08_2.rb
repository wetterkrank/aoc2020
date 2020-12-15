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

data = File.open('aoc08_input.txt').read.lines(chomp: true)
backup = data
candidates = data.each_index.select { |i| data[i].match?(/jmp|nop/) }

result = candidates.detect do |i|
  data = backup.dup.map(&:dup)
  data[i].include?('jmp') ? data[i].sub!('jmp', 'nop') : data[i].sub!('nop', 'jmp')

  result = run(data)
  break result if result
end

p result
