# A simple class, to see if Crystal string interpolation allows both
# {@attribute} and #@attribute.
class Horse
  def initialize(@name : String)
  end

  def to_s(io)
    io << "A horse, #@name." # Crystal does not support omitting the { } here.
  end
end

h = Horse.new("Bob")
puts h
