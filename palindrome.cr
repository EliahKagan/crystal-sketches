# Program to tell if a string is an anagram, modulo whitespace.

require "option_parser"

# Palindrome-related extensions for strings.
class String
  # Tells if this is a case-insensitive palindrome, ignoring whitespace.
  # Uses the naive reversal-based algorithm.
  def palindrome_by_reversal?
    chars = non_ws_chars
    chars == chars.reverse
  end

  # Tells if this is a case-insensitive palindrome, ignoring whitespace.
  # Uses an easy one-copy outside-in "two pointers" algorithm.
  def palindrome_simple?
    chars = non_ws_chars

    left = 0
    right = chars.size - 1
    while left < right
      return false if chars[left] != chars[right]
      left += 1
      right -= 1
    end

    true
  end

  # Tells if this is a case-insensitive palindrome, ignoring whitespace.
  # Uses a non-copying outside-in "two pointers" algorithm.
  def palindrome_inplace?
    left = 0
    right = size - 1
    while left < right
      while left < right && self[left].whitespace?
        left += 1
      end
      while left < right && self[right].whitespace?
        right -= 1
      end

      return false if self[left].downcase != self[right].downcase

      left += 1
      right -= 1
    end

    true
  end

  # Gets an array of the non-whitespace characters, with case folding.
  # Helper method for palindrome_by_reversal? and palindrome_simple?.
  private def non_ws_chars
    each_char.reject(&.whitespace?).map(&.downcase).to_a
  end
end

# The strategy used to examine a string to determine if it is a palindrome.
enum Strategy
  Reversal
  Simple
  Inplace

  def to_s(io)
    case self
    when Reversal
      io << "reverse_and_compare"
    when Simple
      io << "simple outside-in"
    when Inplace
      io << "in-place outside-in"
    else
      raise "Internal error: can't give name of unrecognized strategy"
    end
  end

  def call(text)
    case self
    when Reversal
      text.palindrome_by_reversal?
    when Simple
      text.palindrome_simple?
    when Inplace
      text.palindrome_inplace?
    else
      raise "Internal error: can't check using unrecognized strategy"
    end
  end
end

# Configuration information obtained from parsing options.
class Configuration
  getter strategy = Strategy::Reversal

  def initialize
    failed = false

    OptionParser.parse do |parser|
      parser.on "-v", "--version", "Show version information and exit" do
        puts "anagram, version 0.2"
        exit 0
      end
      parser.on "-h", "--help", "Show this help and exit" do
        puts parser
        exit 0
      end
      parser.on "-r", "--reversal",
                "Use #{Strategy::Reversal} strategy (default)" do
        @strategy = Strategy::Reversal
      end
      parser.on "-s", "--simple", "Use #{Strategy::Simple} strategy" do
        @strategy = Strategy::Simple
      end
      parser.on "-i", "--inplace", "Use #{Strategy::Inplace} strategy" do
        @strategy = Strategy::Inplace
      end
      parser.invalid_option do |option|
        STDERR.puts "#{PROGRAM_NAME}: error: invalid option: #{option}"
        failed = true
      end
    end

    exit 1 if failed
  end
end

conf = Configuration.new
puts "Using #{conf.strategy.to_s.upcase} strategy."
STDERR.puts "#{PROGRAM_NAME}: warning: no string arguments" if ARGV.empty?

ARGV.each do |text|
  if conf.strategy.call(text)
    puts %{YES, "#{text}" IS a palindrome.}
  else
    puts %{NO, "#{text}" is NOT a palindrome.}
  end
end
