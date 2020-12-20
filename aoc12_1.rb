# https://adventofcode.com/2020/day/12, ferry navigation instructions

DIRS = { N: 0, E: 90, S: 180, W: 270 }

def move(ferry, instruction)
  case instruction[:cmd]
  when 'F'
    dir = DIRS.key(ferry[:heading]).to_s
    raise if dir.nil?
    ferry = move(ferry, { cmd: dir, units: instruction[:units] })
  when 'N'
    ferry[:y] -= instruction[:units]
  when 'S'
    ferry[:y] += instruction[:units]
  when 'E'
    ferry[:x] += instruction[:units]
  when 'W'
    ferry[:x] -= instruction[:units]
  when 'L'
    ferry[:heading] = (ferry[:heading] - instruction[:units]) % 360
  when 'R'
    ferry[:heading] = (ferry[:heading] + instruction[:units]) % 360
  else
    raise
  end

  return ferry
end

ferry = { x: 0, y: 0, heading: 90 }

File.open('aoc12_input.txt').each do |line|
  instruction = { cmd: line[0], units: line[1..-1].to_i }
  ferry = move(ferry, instruction)
  puts "#{instruction}: #{ferry}"
end

p ferry[:x].abs + ferry[:y].abs
