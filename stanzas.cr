module Iterator(T)
  def take_until(&block)
    take_while { |item| !yield(item) }
  end
end

loop do
  lines = ARGF.each_line.map(&.rstrip).take_until(&.empty?).to_a
  break if lines.empty?
  lines.each { |line| puts line }
end
