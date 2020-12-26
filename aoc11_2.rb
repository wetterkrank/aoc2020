# https://adventofcode.com/2020/day/11, ferry seats

DIRS = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]

def lookaround(data, y, x, ymax, xmax)
  max_dst = [x, y, xmax - x, ymax - y].max # this could be specific to current look direction though
  DIRS.count do |dir|
    (1..max_dst).any? do |dst|
      ly = y + dir[0] * dst
      lx = x + dir[1] * dst
      break false if [-1, ymax + 1].include?(ly) || [-1, xmax + 1].include?(lx)
      break false if data[ly][lx] == 'L'

      data[ly][lx] == '#'
    end
  end
end

data = File.open('aoc11_input.txt').read.lines(chomp: true).map(&:chars)
xmax = data.first.length - 1
ymax = data.count - 1

iter = data.dup.map(&:dup)
loop do
  (0..ymax).each do |y|
    (0..xmax).each do |x|
      case data[y][x]
      when 'L'
        iter[y][x] = '#' unless lookaround(data, y, x, ymax, xmax).positive?
      when '#'
        iter[y][x] = 'L' if lookaround(data, y, x, ymax, xmax) >= 5
      end
    end
  end
  break if iter == data

  data = iter.dup.map(&:dup)
end

puts data.flatten.count('#')
