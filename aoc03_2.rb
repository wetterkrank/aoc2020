# https://adventofcode.com/2020/day/3

WIDTH = 31
slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
hits = [0, 0, 0, 0, 0]

File.foreach('aoc03_input.txt').with_index do |line, i|
  terrain = line.chomp.gsub('.', '0').gsub('#', '1').reverse.to_i(2)
  slopes.each_with_index do |slope, n|
    next if (i % slope[1]).positive? # skip some rows

    toboggan = slope[0] * i / slope[1] % WIDTH # move right, correcting for skipped rows
    hits[n] += (2**toboggan & terrain).positive? ? 1 : 0
  end
end

puts hits
puts hits.reduce(:*)
