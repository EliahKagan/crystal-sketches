s = "42"
x = s.to_u16?
p typeof(x)
if x
  p typeof(x)
  y : UInt16 = x
  p typeof(y)
end
