class Horse
  def initialize(@name : String)
  end

  def to_s
    "A horse, #{@name}."
  end

  def to_s(io)
    io << to_s
  end
end

h = Horse.new("Bob")
puts h
