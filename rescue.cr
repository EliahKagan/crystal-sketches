require "big"

class String
  def parse_bigint?
    result = BigInt.new(self)
    puts "win(#{result})"
    result
  rescue ArgumentError
    puts %{fail("#{self}")}
    nil
  end
end

ARGV.map(&.parse_bigint?).reject(&.nil?).each do |value|
  puts "Got #{value}."
end
