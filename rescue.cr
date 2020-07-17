require "big"

def parse(text)
  BigInt.new(text)
rescue ArgumentError
  puts "fail"
  nil
ensure
  puts "win"
end

ARGV.each do |arg|
  puts "Got #{value}." if (value = parse(arg))
end
