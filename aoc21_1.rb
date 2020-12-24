# https://adventofcode.com/2020/day/21, Allergen Assessment

data = File.open('aoc21_input.txt').read.lines(chomp: true)
data.map! do |line|
  txt = /^(.+) \(contains (.+)\)$/.match(line)
  ingrs = txt[1].split
  allergs = txt[2].split(', ')
  [ingrs, allergs]
end

allergens = data.each_with_object({}) do |rec, list|
  ingrs = rec.first
  allergs = rec.last
  allergs.each do |allerg|
    list[allerg] = [] if list[allerg].nil?
    list[allerg] << ingrs
  end
end

ingredients = data.each_with_object({}) do |rec, list|
  rec[0].each do |ingr|
    list[ingr] = [] if list[ingr].nil?
    list[ingr] << rec[1]
  end
end

cleared = ingredients.select do |ingr, allergs|
  allergs.flatten.uniq.all? { |allerg| allergs.flatten.count(allerg) < allergens[allerg].count }
end.keys

result = cleared.reduce(0) { |total, ingr| total + data.reduce(0) { |sum, rec| sum + rec.first.count(ingr) } }

p result
