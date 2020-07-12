def push_block(array, &block)
  array.push(block)
end

acts = [] of Proc(Nil)

%w[Alice Bob Cassidy].each do |name|
  push_block(acts) { puts "Hello, #{name}!" }
end

acts.each(&.call)
