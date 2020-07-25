# https://crystal-lang.org/reference/syntax_and_semantics/block_forwarding.html

def capture(&block)
  block
end

def twice
  yield
  yield
end

twice &->{ puts "Hello" }
