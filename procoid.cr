# Does &obj work when obj is not a proc but has a call method?

words = %w[foo bar baz quux foobar]

# With a proc:
tc1 = ->(word : String) { word[0].upcase + word[1..] }
pp words.map(&tc1)

# A "procoid" class whose instances behave like tc1 above.
class TitleCaser
  def call(word)
    word[0].upcase + word[1..]
  end
end

# With a procoid:
tc2 = TitleCaser.new
#pp words.map(&tc2) # Compile error. & syntax doesn't support this.
pp words.map { |word| tc2.call(word) }
