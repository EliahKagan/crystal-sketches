n = ARGV[0].to_i
n += 1 if ENV.has_key?("INCREMENT")
p n
