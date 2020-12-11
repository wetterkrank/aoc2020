# https://adventofcode.com/2020/day/3

slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
hits = [0, 0, 0, 0, 0]

File.foreach('aoc03_input.txt').with_index do |line, i|
  terrain = line.chomp
  slopes.each_with_index do |slope, n|
    next if (i % slope[1]).positive? # skip some rows

    toboggan = slope[0] * i / slope[1] % terrain.length # move right, correcting for skipped rows
    hits[n] += 1 if terrain[toboggan] == '#'
  end
end

p hits
puts hits.reduce(:*)
