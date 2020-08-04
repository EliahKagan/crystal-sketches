# Originally I had this as add_ by accident and the add(1, 2) call converted
# the arguments to floats and called the other one.
def add(x : Int32, y : Int32)
  x + y
end

def add(x : Float64, y : Float64)
  x + y
end

p add(1, 2)
p add(0.1, 0.2)
