# https://adventofcode.com/2020/day/13, bus schedules

data = File.open('aoc13_input.txt').read.split($/)

now = data[0].to_i
buses = data[1].split(',').reject { |id| id == 'x' }.map(&:to_i)
departures = buses.each_with_object({}) { |id, deps| deps[id] = id - now % id }

puts departures.min_by { |k, v| v }.reduce(:*)
