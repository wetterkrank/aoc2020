# https://adventofcode.com/2020/day/16, what's in my ticket

data = File.open('aoc16_input.txt').read.split("\n\n")

f_names = data[0].lines(chomp: true).map { |line| line.split(': ')[0] }
f_values = data[0].lines(chomp: true).map { |line| line.split(': ')[1] }
f_values.map! { |ranges| ranges.split(' or ').map { |rng| Range.new(rng.split('-')[0].to_i, rng.split('-')[1].to_i) } }

fields = Hash[f_names.zip(f_values)]
tickets = data[2].lines(chomp: true)[1..-1].map { |ticket| ticket.split(',').map(&:to_i) }

# just look for invalid fields and sum them up
invalid_fields = tickets.flatten.reject { |val| fields.values.flatten.any? { |rng| rng.cover?(val) } }
p invalid_fields.sum
