# https://adventofcode.com/2020/day/25, Combo Breaker

pubkeys = [14012298, 74241] # input
# pubkeys = [5764801, 17807724] # test

def transform(subj, loop_size)
  loop_size.times.reduce(1) { |v, _| v * subj % 20201227 }
end

v = 1
secret0 = 1.step do |i|
  v = v * 7 % 20201227
  break i if v == pubkeys[0]
end

enc_key = transform(pubkeys[1], secret0)
puts enc_key
