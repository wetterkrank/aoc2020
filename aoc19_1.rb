# https://adventofcode.com/2020/day/19, Monster Messages

def unpack(obj, rules)
  return obj if obj.is_a? String
  return unpack(rules[obj], rules) if obj.is_a? Integer

  obj.map { |item| unpack(item, rules) }.flatten.prepend('(').append(')').join
end

data = File.open('aoc19_input.txt').read.split("\n\n").map { |sec| sec.lines(chomp: true) }
rules = data[0]
messages = data[1]

# Make the array of rules
rules = rules.each_with_object(Array.new(rules.count)) do |line, arr|
  i, txt = line.split(': ')
  txt = txt.gsub(/\"/, '').split
  txt = txt.map { |num| num.to_i.zero? ? num : num.to_i }
  arr[i.to_i] = txt
end

pattern = Regexp.new("^#{unpack(rules[0], rules)}$")
count = messages.count { |msg| pattern.match? msg }

puts count
