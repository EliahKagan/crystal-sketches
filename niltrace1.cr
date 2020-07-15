def i32_or_default(text : String, default : Int32)
  value = text.to_i?
  if value
    value
  else
    default
  end
end

x = i32_or_default("100", 42)
y = i32_or_default("10z", 42)

puts "x #{typeof(x)} #{x.class} #{x}"
puts "y #{typeof(y)} #{y.class} #{y}"
