# https://adventofcode.com/2020/day/5, Binary Boarding

data = File.open('aoc05_input.txt').read.split
seats = data.map { |line| line.chomp.gsub(/[FL]/, '0').gsub(/[BR]/, '1').to_i(2) }

gap = seats.sort.each_cons(2) { |a, b| break a + 1 if a + 1 != b }
puts gap
