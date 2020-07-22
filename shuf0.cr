require "random"

class Array(T)
  def knuth_shuffle
    self.size.downto(2) do |unshuffled_size|
      self.swap(unshuffled_size - 1, rand(unshuffled_size))
    end
  end
end

lines = ARGF.each_line.to_a
lines.knuth_shuffle
lines.each { |line| puts line }
