# https://adventofcode.com/2020/day/7, luggage processing rules

rules = File.open('aoc07_input.txt').read.lines(chomp: true)
bags = [' shiny gold']

loop do
  matching_rules = rules.filter { |rule| rule.match? Regexp.union(bags) }
  matching_bags = matching_rules.map { |rule| " #{rule.split[0..1].join(' ')}" }
  unchecked = matching_bags - bags
  break if unchecked.empty?

  bags += matching_bags
  bags.uniq!
end

bags -= [' shiny gold']
p bags.count
