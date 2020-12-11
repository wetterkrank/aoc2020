# https://adventofcode.com/2020/day/1

file = File.open('aoc01_input.txt')
data = file.readlines.map { |x| x.chomp.to_i }

while data.length.positive?
  a = data.pop
  b = 2020 - a
  if data.index(b)
    puts "#{a} * #{b} = #{a * b}"
    break
  end
end
