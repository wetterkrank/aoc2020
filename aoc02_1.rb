# https://adventofcode.com/2020/day/2

file = File.open('aoc02_input.txt')

data = file.readlines.map do |line|
  parts = line.chomp.split(' ')
  { min: parts[0].split('-')[0].to_i, 
    max: parts[0].split('-')[1].to_i,
    ch: parts[1].chomp(':'),
    pwd: parts[2] }
end

valid = data.filter { |entry| entry[:pwd].count(entry[:ch]).between?(entry[:min], entry[:max]) }
p valid.count
