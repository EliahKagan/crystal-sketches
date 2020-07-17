class ContrivedError < Exception
end

def run
  raise ContrivedError.new("first contrived error")
rescue ContrivedError
  raise ContrivedError.new("second contrived error")
rescue ContrivedError # Allowed, but never actually executes.
  raise ContrivedError.new("third contrived error")
end

run
