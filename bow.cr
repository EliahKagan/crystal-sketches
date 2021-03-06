require "big"

# Extends Number with bad and (fairly) good recursive exponentiation.
struct Number
  # Bad power function. Not likely to overflow the stack though...
  def bow(exponent : Int)
    raise ArgumentError.new("negative exponent unsupported") if exponent < 0

    return self.class.new(1) if exponent.zero?

    result = bow(exponent // 2) * bow(exponent // 2) # lol
    result *= self if exponent.odd?
    result
  end

  # Good power function.
  def gow(exponent : Int)
    raise ArgumentError.new("negative exponent unsupported") if exponent < 0

    return self.class.new(1) if exponent.zero?

    result = gow(exponent // 2)
    result *= result
    result *= self if exponent.odd?
    result
  end
end

# Performs a binary operation, reports timings, and returns the result.
def test(base, exponent, label, &block)
  result = nil
  elapsed = Time.measure { result = yield base, exponent }
  printf "%-4s:  %s  %s\n", label, result, elapsed
  result
end

# Tests all three exponentiation implementations, and compares their results.
def test_all(base, exponent)
  by_std = test(base, exponent, "**") { |b, e| b**e }
  by_bow = test(base, exponent, "bow") { |b, e| b.bow(e) }
  by_gow = test(base, exponent, "gow") { |b, e| b.gow(e) }

  unless by_std == by_bow == by_gow
    STDERR.puts "#{PROGRAM_NAME}: warning: the results differ!"
  end
end

# Print a error message and exit, indicating failure.
def die(message)
  STDERR.puts "#{PROGRAM_NAME}: error: #{message}"
  exit 1
end

EXAMPLE_BASE = 3
EXAMPLE_EXPONENT = 100

if ARGV.empty?
  puts "No arguments. Showing #{EXAMPLE_BASE} to the #{EXAMPLE_EXPONENT}."
  test_all(BigInt.new(EXAMPLE_BASE), EXAMPLE_EXPONENT)
  exit 0
end

die("too few arguments") if ARGV.size < 2
die("too many arguments") if ARGV.size > 2

begin
  base = BigInt.new(ARGV[0])
rescue error : ArgumentError
  die("bad base: #{error}")
end

begin
  exponent = Int32.new(ARGV[1])
rescue error : ArgumentError
  die("bad exponent: #{error}")
end

puts "Computing #{base} to the #{exponent}."
test_all(base, exponent)
