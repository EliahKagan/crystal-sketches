class Horse
  def initialize(@name : String)
  end

  def to_s(io)
    io << "A horse, #{@name}."
  end
end

h = Horse.new("Bob")
puts h
