module Iterator(T)
  def take_until(&block : T -> B) forall B
    take_while { |item| !block.call(item) }
  end
end

loop do
  lines = ARGF.each_line.map(&.rstrip).take_until(&.empty?).to_a
  break if lines.empty?
  lines.each { |line| puts line }
end
