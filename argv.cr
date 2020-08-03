answer = 42
p typeof(answer)
answer = ARGV[0] unless ARGV.empty?
p typeof(answer)
answer = 1.234 if answer.is_a?(Int32)
p typeof(answer)
