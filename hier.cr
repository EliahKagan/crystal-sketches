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
    copy = @tree
    climb copy
  end
end

tree = Pine.new
climber = Climber.new(tree)
pp climber.tree
