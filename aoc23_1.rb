# https://adventofcode.com/2020/day/23, Crab Cups

def pickup(arr, pos, count)
  # no check for count > length
  whole = arr.clone
  piece = count.times.with_object([]) do |_, obj|
    obj << whole.delete_at(pos % whole.length)
    pos = pos >= whole.length ? 0 : pos
  end
  [whole, piece]
end

def insert(arr, pos, items)
  # doesn't check pos validity or array's resulting length
  newarr = arr.clone
  newarr.insert(pos, *items)
end

def next_minor(arr, num)
  # no check for duplicate values
  tmp = arr.clone.sort.reverse
  pos = tmp[(tmp.find_index(num).nil? ? 0 : tmp.find_index(num) + 1) % tmp.length]
  arr.find_index(pos)
end

# data = '389125467' # test
data = '853192647' # input
data = data.chars.map(&:to_i)

len = data.length
current = data.first

100.times do |i|
  puts "-- move #{i+1} --"
  puts "cups: #{data} (#{current})"

  data, part = pickup(data, (data.find_index(current) + 1) % len, 3)
  puts "pick up: #{part}"

  dest_i = next_minor(data, current)
  puts "destination: #{data[dest_i]}"
  puts

  data = insert(data, (dest_i + 1) % len, part)
  current = data[(data.find_index(current) + 1) % len]
end

puts '-- final --'
puts "cups: #{data} (#{current})"
