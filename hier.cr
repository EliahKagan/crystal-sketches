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

x = true ? Pine.new : Maple.new
p typeof(x)
