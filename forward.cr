def collect_to_array(&block : (Symbol -> Nil) -> Nil)
  results = [] of Symbol # Can this be made generic?
  # block.call { |res| results << res } # yield { |res| results << res }
  block.call &(->(res : Symbol) { results << res })
  results
end

def each_day(&block)
  yield :sunday
  yield :monday
  yield :tuesday
  yield :wednesday
  yield :thursday
  yield :friday
  yield :saturday
end

producer = ->(proc : Symbol -> Nil) { each_day &proc }

days = collect_to_array &producer

#days = collect_to_array &(->(proc : Proc(Symbol, Nil)) { each_day &proc })
