# https://adventofcode.com/2020/day/22, Crab Combat

def round(p1, p2)
  if p1.first > p2.first
    p1 << p1.shift
    p1 << p2.shift
  else
    p2 << p2.shift
    p2 << p1.shift
  end
end

def score(deck)
  deck.reverse.each_with_index.reduce(0) { |acc, (x, i)| acc + x * (i + 1) }
end

data = File.open('aoc22_input.txt').read
p1, p2 = data.split("\n\n").map { |block| block.lines(chomp: true)[1..-1].map(&:to_i) }

round(p1, p2) while p1.length > 0 && p2.length > 0

result = score(p1.length > p2.length ? p1 : p2)
p result
