# def f(t : Tuple(T, T)) forall T
#   puts "Called f with #{t}. typeof(t)==#{typeof(t)}. t.class=#{t.class}."
# end

def f(t : Tuple(Int32, Int32))
  puts "Pair of Int32."
end

def f(t : Tuple(String, String))
  puts "Pair of String."
end

u = {10, 20}
v = {"foo", "bar"}

f(u)
f(v)

w = rand < 0.5 ? u : v
f(w) # compile error!
