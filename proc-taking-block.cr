# In Crystal, can a proc take a block?

fn = ->(text : String, &block : Proc(Char, Nil)) do
  text.each_char { |ch| block.call(ch) }
end
