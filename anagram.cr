# Program to tell if strings are anagrams, modulo whitespace.

require "option_parser"

# Make lazy sequences sortable, creating a new array.
module Iterator
  def sort
    to_a.sort!
  end
end

# Anagram-related extensions for strings.
class String
  # Tells if this is an anagram of another string, ignoring whitespace.
  # Uses sorting.
  def anagram_by_sort?(other)
    each_non_ws_char.sort == other.each_non_ws_char.sort
  end

  # Tells if this is an anagram of another string, ignoring whitespace.
  # Uses hashing.
  def anagram_by_hash?(other)
    freqs = Hash(Char, Int32).new(0)
    each_non_ws_char { |ch| freqs[ch] += 1 }
    other.each_non_ws_char { |ch| freqs[ch] -= 1 }
    freqs.values.all? &.zero?
  end

  # Gets a sequence of the non-whitespace characters, with case folding.
  protected def each_non_ws_char
    each_char.reject(&.whitespace?).map(&.downcase)
  end

  # Performs an action on each non-whitespace character, with case folding.
  protected def each_non_ws_char
    each_non_ws_char.each { |ch| yield ch }
  end
end

# The strategy used to compare strings to determine if they are anagrams.
enum Strategy
  Sort
  Hash

  def to_s(io)
    case self
    when Sort
      io << "SORTING"
    when Hash
      io << "HASHING"
    else
      raise "Internal error: can't give name of unrecognized strategy"
    end
  end

  def call(lhs, rhs)
    case self
    when Sort
      lhs.anagram_by_sort?(rhs)
    when Hash
      lhs.anagram_by_hash?(rhs)
    else
      raise "Internal error: can't compare using unrecognized strategy"
    end
  end
end

# Represents configuration information obtained from parsing options.
class Configuration
  getter strategy = Strategy::Sort

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
      parser.on "-S", "--sort",
                "Use sorting-based anagram comparison (default)" do
        @strategy = Strategy::Sort
      end
      parser.on "-H", "--hash", "Use hashing-based anagram comparison" do
        @strategy = Strategy::Hash
      end
      parser.invalid_option do |option|
        STDERR.puts "#{PROGRAM_NAME}: error: invalid option: #{option}"
        failed = true
      end
    end

    exit 1 if failed
  end
end

def prompt(label)
  print "#{label}> "
  input = gets
  exit 0 unless input
  input
end

conf = Configuration.new
puts "Using #{conf.strategy} anagram-comparison strategy."

loop do
  puts
  puts "Enter two strings, or Ctrl+D to quit."
  text1 = prompt(1)
  text2 = prompt(2)

  if conf.strategy.call(text1, text2)
    puts "YES, those ARE anagrams."
  else
    puts "NO, those are NOT anagrams."
  end
end
