class DisjointSets
  @parents : Array(Int32)
  @ranks : Array(Int32)

  def initialize(count)
    @parents = (0...count).to_a
    @ranks = Array.new(count, 0)
  end

  def union(elem1, elem2)
    # Find the ancestors and stop if they are the same.
    elem1 = findset(elem1)
    elem2 = findset(elem2)
    return false if elem1 == elem2

    # Unite by rank.
    if @ranks[elem1] < @ranks[elem2]
      @parents[elem1] = elem2
    else
      @ranks[elem1] += 1 if @ranks[elem1] == @ranks[elem2]
      @parents[elem2] = elem1
    end

    return true
  end

  def findset(elem)
    # Find the ancestor.
    leader = elem
    while leader != @parents[leader]
      leader = @parents[leader]
    end

    # Compress the path.
    while elem != leader
      parent = @parents[elem]
      @parents[elem] = leader
      elem = parent
    end

    leader
  end
end


n = 10

sets = DisjointSets.new(n)
sets.union(1, 7)
sets.union(3, 8)
sets.union(2, 4)
sets.union(8, 9)
sets.union(4, 7)
#sets.union(2, 9)
sets.union(0, 4)

(0...n).each do |i|
  print "#{i}:"

  (0...n).each do |j|
    print " #{j}" if sets.findset(j) == i
  end

  puts
end
