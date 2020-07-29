# Creates a proc that, when called, prints a value and its type.
def f(n : Int32?)
  if n.nil?
    puts "Got nil."
    ->{ puts "No capture." }
  else
    puts "Got #{typeof(n)}."
    ->{ puts "Captured #{typeof(n)}." }
  end
end

if ARGV.empty?
  puts "You must pass an argument."
  exit 1
end

n = ARGV[0].to_i?
g = f(n)
g.call
