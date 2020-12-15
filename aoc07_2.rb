# https://adventofcode.com/2020/day/7, luggage processing rules

# returns the rules hash { bag => {another_bag: number, one_more_bag: number} }
def parse(input)
  output = {}
  input.each do |line|
    parts = line[0..-2].partition(' bags contain ')
    container = parts[0]
    contents = parts[2].split(', ').to_h { |c| [c.split[1..2].join(' '), c.split[0].to_i] }
    output[container] = contents
  end
  output
end

# walks the rules hash and sums up the values
def sum_children(records, parent, total = 0)
  return 0 if records[parent].nil?

  records[parent].each do |child, how_many|
    total += how_many
    total += how_many * sum_children(records, child)
  end
  total
end

data = File.open('aoc07_input.txt').read.lines(chomp: true)
rules = parse data
puts sum_children(rules, 'shiny gold')
