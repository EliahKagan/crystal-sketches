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
  getter tree : Pine | Maple

  def initialize(@tree)
    climb @tree
  end
end

climber = Climber.new(Pine.new)
pp climber.tree
