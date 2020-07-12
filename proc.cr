acts = %w[Alice Bob Cassidy].map do |name|
  ->() { puts "Hello, #{name}!" }
end

acts.each(&.call)
