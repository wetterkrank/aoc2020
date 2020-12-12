# https://adventofcode.com/2020/day/5

data = File.open('aoc05_input.txt').read.split
seats = data.map { |line| line.chomp.gsub(/[FL]/, '0').gsub(/[BR]/, '1').to_i(2) }

p seats.max
