acts = %w[Alice Bob Cassidy].map do |name|
  ->{ puts "Hello, #{name}!" }
end

acts.insert(-2, ->{ return })
acts.each(&.call)
