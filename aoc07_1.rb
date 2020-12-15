# https://adventofcode.com/2020/day/7, luggage processing rules

require 'set'

# returns the hash { bag => [list of its containers] }
def parse_up(input)
  output = {}
  input.each do |line|
    parts = line[0..-2].partition(' bags contain ')
    container = parts[0]
    contents = parts[2].split(', ').map { |c| c.split[1..2].join(' ') }
    contents.each { |c| (output[c] ||= []) << container }
  end
  output
end

# walks the rules hash and returns the set containing all item's parents
def get_parents(records, child, result = Set[])
  return if records[child].nil?

  records[child].each do |parent|
    result << parent
    get_parents(records, parent, result)
  end
  result
end

data = File.open('aoc07_input.txt').read.lines(chomp: true)
rules = parse_up data
puts get_parents(rules, 'shiny gold').count
