# https://adventofcode.com/2020/day/4

REQUIRED = %w(byr iyr eyr hgt hcl ecl pid)
data = File.open('aoc04_input.txt').read.split("\n\n")

result = data.count do |passport|
  fields = passport.split(/[\s\n]/).map { |f| f.split(':')[0] }
  REQUIRED.all? { |req| fields.include?(req) }
end

p result
