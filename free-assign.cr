# Not called.
def f=(value)
  puts %{"Assigned #{vaue}."}
end

f = 42 # Does NOT call f=.
