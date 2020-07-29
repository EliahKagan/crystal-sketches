# Creates a proc that, when called, prints a value and its type.
def make_printer(x)
  ->do
    puts "Value #{x}, #{typeof(x)} (static), #{x.class} (dynamic). [In proc.]"
  end
end

x = gets
puts "Value #{x}, #{typeof(x)} (static), #{x.class} (dynamic)."
exit if x.nil?
puts "Value #{x}, #{typeof(x)} (static), #{x.class} (dynamic)."
f = make_printer(x)
puts "Value #{x}, #{typeof(x)} (static), #{x.class} (dynamic)."
f.call
puts "Value #{x}, #{typeof(x)} (static), #{x.class} (dynamic)."
