# Program to tell if strings are anagrams, modulo whitespace.

# Anagram-related extensions for strings.
class String
  # Gets an array of non-whitespace characters, with repetitions, in
  # lexicographic order, with case-folding applied, from this string.
  def non_ws_chars
    self.downcase.each_char.reject(&.whitespace?).to_a.sort!
  end

  # Tells if this string is an anagram of another, ignoring whitespace.
  def anagram_of?(other)
    self.non_ws_chars == other.non_ws_chars
  end
end

def prompt(label)
  print "#{label}> "
  input = gets
  exit 0 unless input
  input
end

loop do
  puts "Enter two strings, or Ctrl+D to quit."
  text1 = prompt(1)
  text2 = prompt(2)
  
  if text1.anagram_of?(text2)
    puts "YES, those are anagrams."
  else
    puts "NO, those are not anagrams."
  end

  puts
end
