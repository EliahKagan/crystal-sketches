# Reads a line as an array of integers.
def read_record()
  if line = gets
    line.split.map(&.to_i)
  else
    [] of Int32
  end
end

pp read_record
