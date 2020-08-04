class Tree
end

class Pine < Tree
end

class Maple < Tree
end

class Willow < Tree
end

p Pine | Maple
p (Pine | Maple) == Tree
