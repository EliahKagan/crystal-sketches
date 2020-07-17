class ContrivedError < Exception
end

def run
  begin
    raise ContrivedError.new("first contrived error")
  rescue ContrivedError
    raise ContrivedError.new("second contrived error")
  end
rescue ContrivedError
  raise ContrivedError.new("third contrived error")
end

run
