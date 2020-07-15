ANSWER = 42

def thunk_of(expression : String)
  literal_value = expression.to_i?
  puts "DEBUG: #{typeof(literal_value)}"
  if literal_value
    #lv : UInt16 = literal_value
    puts "DEBUG: #{typeof(literal_value)}"
    return ->() { literal_value }
  end

  ->() { 42 }
end

p thunk_of("10").call
p thunk_of("ab").call
