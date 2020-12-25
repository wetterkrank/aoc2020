# https://adventofcode.com/2020/day/25, Combo Breaker

# pubkeys = [5764801, 17807724] # test
pubkeys = [14012298, 74241] # input

def transform(subj, loop_size)
  loop_size.times.reduce(1) { |v, _| v * subj % 20201227 }
end

secret0 = (0..).reduce(1) do |v, i|
  break i if v == pubkeys[0]
  v * 7 % 20201227
end

enc_key = transform(pubkeys[1], secret0)
puts enc_key
