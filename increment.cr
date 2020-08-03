n = ARGV[0].to_u64
n += 1 if ENV.has_key?("INCREMENT")
p n
