# https://adventofcode.com/2020/day/18, Operation Order

class Integer
  def -(obj)
    self * obj
  end
end

result = File.open('aoc18_input.txt').read.lines(chomp: true).reduce(0) do |acc, line|
  acc + eval(line.gsub('*', '-'))
end

puts result
