# https://adventofcode.com/2020/day/10

def get_suitable_adapters(data, current)
  data.filter { |adp| adp > current && adp <= current + 3 }
end

def select_next_adapter(list, current)
  list[current].min
end

def build_route(list, start, target)
  i = start
  route = [i]
  loop do
    i = select_next_adapter(list, i)
    route << i
    break if i.nil? || i == target
  end
  route
end

def count_diffs(route, diff)
  sum = 0
  route.each_cons(2) { |pair| sum += 1 if pair[1] - pair[0] == diff }
  sum
end

file = File.open('aoc10_input.txt')
data = file.readlines.map { |x| x.chomp.to_i }

target = data.max + 3
data << 0
data << target

list = data.to_h { |adp| [adp, get_suitable_adapters(data, adp)] }
route = build_route(list, 0, target)

p count_diffs(route, 1) * count_diffs(route, 3)
