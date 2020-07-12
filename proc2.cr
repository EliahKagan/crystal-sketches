def make_counter(start)
  ->() do
    ret = start
    start += 1
    ret
  end
end

f = make_counter(10)
g = make_counter(20)

p f.call
p f.call
p f.call
p g.call
p g.call
p f.call
