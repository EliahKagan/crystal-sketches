def i32_or_default(text : String, default : Int32)
  value = text.to_i?
  if value
    copy = value
    -> { copy }
  else
    -> { default }
  end
end

f = i32_or_default("100", 42)
g = i32_or_default("10z", 42)
x = f.call
y = g.call

puts "f   #{typeof(f)}   #{f.class}"
puts "g   #{typeof(g)}   #{g.class}"
puts "x   #{typeof(x)}   #{x.class}   #{x}"
puts "y   #{typeof(y)}   #{y.class}   #{y}"
