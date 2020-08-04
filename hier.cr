class Tree
end

class Pine < Tree
end

class Maple < Tree
end

class Willow < Tree
end

def climb(tree : Pine | Maple)
end

# climb Willow.new
p Pine | Maple
p Pine | Maple == Tree
p Pine | Maple == Pine | Willow == Maple | Willow == (Tree+)
