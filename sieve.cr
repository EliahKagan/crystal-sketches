# Simple Sieve of Eratosthenes implementation. Not well optimized.

require "bit_array"
require "math"

# Helper function for sieve().
def raw_sieve(bound)
  maybe_prime = BitArray.new(bound + 1, true)

  (3..Math.sqrt(bound).to_i).step(2) do |factor|
    next unless maybe_prime[factor]

    (factor**2..bound).step(factor * 2) do |multiple|
      maybe_prime[multiple] = false
    end
  end

  maybe_prime
end

# Sieve of Eratosthenes.
def sieve(bound)
  return if bound < 2

  maybe_prime = raw_sieve(bound)
  yield 2

  (3..bound).step(2) do |value|
    yield value if maybe_prime[value]
  end
end

sieve(ARGV[0].to_i) { |prime| puts prime }
