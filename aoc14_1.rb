# https://adventofcode.com/2020/day/14

def update_mask(str)
  mask_or = str.gsub('X', '0')
  mask_and = str.gsub('X', '1')
  { or: mask_or.to_i(2), and: mask_and.to_i(2) }
end

data = File.open('aoc14_input.txt').read.lines(chomp: true)
mem = {}
mask = 0

data.each do |line|
  cmd, _, arg = line.partition(' = ')
  if cmd == 'mask'
    mask = update_mask(arg)
  else
    cell = cmd.split('[')[1][0..-2]
    mem[cell] = (arg.to_i & mask[:and]) | mask[:or]
  end
end

p mem.values.sum
