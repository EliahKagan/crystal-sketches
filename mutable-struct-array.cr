struct Point
  property x
  property y

  def initialize(@x : Float64, @y : Float64)
  end
end

a = [Point.new(10, 20), Point.new(1.5, 3.6), Point.new(0, 0)]
puts a
a[2].y = 0.5 # Changes the temporary copy. Does NOT change a[2], unlike in C#.
puts a
