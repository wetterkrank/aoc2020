# https://adventofcode.com/2020/day/4

REQUIRED = { 'byr' => '^(19[2-9][0-9]|200[0-2])$',
             'iyr' => '^(201[0-9]|2020)$',
             'eyr' => '^(202[0-9]|2030)$',
             'hgt' => '^(1[5-8][0-9]cm|19[0-3]cm|59in|6[0-9]in|7[0-6]in)$',
             'hcl' => '^#[0-9a-f]{6}$',
             'ecl' => '^(amb|blu|brn|gry|grn|hzl|oth)$',
             'pid' => '^\d{9}$' }

data = File.open('aoc04_input.txt').read.split("\n\n")

result = data.count do |passport|
  fields = passport.split(/[\s\n]/).map { |f| f.split(':') }.to_h
  REQUIRED.all? { |req, mask| fields.keys.include?(req) && fields[req].match?(mask) }
end

p result
