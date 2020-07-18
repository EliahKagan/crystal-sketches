require "big"

struct Number
  def pown(exponent)
    return self.class.new(1) if exponent.zero?

    power = self.pown(exponent // 2)
    power *= power
    power *= self if exponent.odd?
    power
  end
end

def die(message)
  STDERR.puts("#{PROGRAM_NAME}: error: #{message}")
  exit 1
end

def parse_base(text)
  begin
    BigInt.new(text)
  rescue ArgumentError
    text.to_f
  end
rescue ArgumentError
  die "non-numeric base: #{text}"
end

def parse_exponent(text)
  exponent = text.to_i
  die "negative exponents not supported" if exponent < 0
  exponent
rescue ArgumentError
  begin
    _ = BigInt.new(text)
  rescue ArgumentError
    die "non-integer exponent: #{text}"
  end
  die "exponent too big: #{text}"
end

die "too few arguments" if ARGV.size < 2
die "too many arguments" if ARGV.size > 2

base = parse_base(ARGV[0])
exponent = parse_exponent(ARGV[1])
puts base.pown(exponent)
