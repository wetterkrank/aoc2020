# https://adventofcode.com/2020/day/11, ferry seats

def count_neigbours(data, x, y, xmax, ymax)
  hood = data[[y - 1, 0].max..[y + 1, ymax].min].map { |row| row[[x - 1, 0].max..[x + 1, xmax].min] }
  hood.flatten.count('#') - (data[y][x] == '#' ? 1 : 0)
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
        iter[y][x] = '#' unless count_neigbours(data, x, y, xmax, ymax).positive?
      when '#'
        iter[y][x] = 'L' if count_neigbours(data, x, y, xmax, ymax) >= 4
      end
    end
  end
  break if iter == data

  data = iter.dup.map(&:dup)
end

p data.flatten.count('#')
