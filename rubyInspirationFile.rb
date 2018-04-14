require 'pp'
require 'set'

def rollxdy(x, y)
  sum = x
  x.times do
    sum += rand(y)
  end
  return sum
end

def generateStats(collection, die_number, die_size, base)
  stats = []
  6.times do
    stats << (base + rollxdy(die_number, die_size))
  end
  stats.sort!.reverse
  collection[stats] += 1
end

collection = Hash.new(0)

10000.times do
  generateStats(collection, 3, 4, 4)
end

collection.keys.each do |stat_group|
  sum = stat_group.reduce(:+)
  collection[stat_group] = {total: collection[stat_group], sum: sum}
end

# grabs a sorted list of all sums
sums = collection.values.reduce(SortedSet.new) do |set, data|
  set.add(data[:sum])
  set
end

by_sum = sums.reduce({}) do |hsh, sum|
  hsh[sum] = {times:0, collections: []}
  hsh
end

collection.each do |stats, data|
  by_sum[data[:sum]][:times] += 1
  by_sum[data[:sum]][:collections] << stats
end


# new_collection = Hash.new(0)
# collection.values.each do |data|
#   new_collection[data[:sum]] +=1
# end


pp by_sum
