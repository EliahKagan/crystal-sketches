class NoisyTriple(TX, TY, TZ)
  def initialize(x : TX, y : TY, z : TZ)
    @x = x
    @y = y
    @z = z
  end

  def to_s(io)
    io << "(#{@x}, #{@y}, #{@z})"
  end

  def x
    puts "Reading x."
    @x
  end

  def x=(value)
    puts "Writing x."
    @x = value
  end

  def y
    puts "Reading y."
    @y
  end

  def y=(value)
    puts "Writing y."
    @y = value
  end

  def z
    puts "Reading z."
    @z
  end

  def z=(value)
    puts "Writing z."
    @z = value
  end
end

def passthrough(value)
  puts "Passing through #{value}."
  value
end

u = NoisyTriple(Int32, Int32, Int32).new(10, 20, 30)
puts "u starts as #{u}."
puts "Assignments are evaluated from right to left:"
u.x = u.y = u.z = passthrough(50)
puts "Now u is #{u}."
