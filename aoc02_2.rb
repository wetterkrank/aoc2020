# https://adventofcode.com/2020/day/2

file = File.open('aoc02_input.txt')

data = file.readlines.map do |line|
  parts = line.chomp.split(' ')
  { p1: parts[0].split('-')[0].to_i - 1,
    p2: parts[0].split('-')[1].to_i - 1,
    ch: parts[1].chomp(':'),
    pwd: parts[2] }
end

valid = data.filter { |entry| (entry[:pwd][entry[:p1]] == entry[:ch]) ^ (entry[:pwd][entry[:p2]] == entry[:ch]) }
p valid.count
