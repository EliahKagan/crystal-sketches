class Widget
  def initialize(x : Int32)
    puts "Constructing from integer."
    @x = x
  end

  def initialize(x : String)
    puts "Constructing from string."
    initialize(x.to_i)
  end

  getter x : Int32
end

w = Widget.new("42")
puts w.x
