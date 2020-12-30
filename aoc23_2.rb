# https://adventofcode.com/2020/day/23, Crab Cups

def link(seed, max)
  buf = []
  (seed.min..max).each { |i| buf[i] = i + 1 }
  seed.each_with_index { |num, i| buf[num] = seed[i + 1] || seed.max + 1 }
  if max > seed.max
    buf[max] = seed.first
  else
    buf[seed.last] = seed.first
  end
  buf
end

# moves forward <offset> times
def seek(llist, current, offset)
  pos = current
  offset.times { pos = llist[pos] }
  pos
end

# returns the array of 3 excluded elements
def extract3(llist, current)
  pos = llist[current]
  exc = []
  3.times do
    exc << pos
    pos = llist[pos] # need all three elements for next dest selection
  end
  llist[current] = llist[exc[2]] # bypass next 3 elements in the linked list
  exc
end

# assuming there are no gaps btw values; returns the destination cup
def find_minor(current, exc, low, high)
  exc << 0
  pos = current - 1
  pos = pos > low ? pos - 1 : high while exc.include? pos
  pos
end

def insert3(llist, dest, exc)
  finish = llist[dest] # save the value following dest
  llist[dest] = exc[0] # connect dest to the 1st excised element
  llist[exc[2]] = finish # connect 3rd excised element to the saved one
end

def get_result(llist, pos = 1)
  result = []
  2.times do
    pos = llist[pos]
    result << pos
  end
  result
end

# data = '389125467' # test
data = '853192647' # input
data = data.chars.map(&:to_i)

min = data.min
current = data.first
max = 1_000_000
ring = link(data, max)

10_000_000.times do
  exc = extract3(ring, current)
  dest = find_minor(current, exc, min, max)
  insert3(ring, dest, exc)
  current = ring[current]
end

result = get_result(ring)
puts result.reduce(:*)
