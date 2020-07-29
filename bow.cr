require "big"

# Extends Int with bad and (fairly) good recursive exponentiation.
struct Int # FIXME: Extend Number instead, if possible.
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

def test(base, exponent, label, &block)
  result = nil
  elapsed = Time.measure { result = yield base, exponent }
  printf "%-4s:  %10d  %s\n", label, result, elapsed
end

def test_all(base, exponent)
  test(base, exponent, "**") { |b, e| b**e }
  test(base, exponent, "bow") { |b, e| b.bow(e) }
  test(base, exponent, "gow") { |b, e| b.gow(e) }
end

THREE = BigInt.new(3)

test_all(THREE, 100)
