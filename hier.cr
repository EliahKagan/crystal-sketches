class Tree
end

class Pine < Tree
end

class Maple < Tree
end

class Willow < Tree
end

def climb(tree : Pine | Maple)
  puts "Climbing #{tree}."
end

class Climber
  property tree : Pine | Maple

  def initialize(@tree)
    copy = tree
    climb copy
  end
end

climber = Climber.new(Pine.new)
pp climber.tree
