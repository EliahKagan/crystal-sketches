# Various sorting algorithms for arrays.
class Array(T)
  # Insertion sort with < comparison.
  def insertionsort
    insertionsort { |ls, rs| ls < rs }
  end

  # Insertion sort with a specified less-than comparison.
  def insertionsort(&block)
    1.upto(size - 1) do |right|
      elem = self[right]

      left = right
      while left > 0 && yield elem, self[left - 1]
        self[left] = self[left - 1]
        left -= 1
      end

      self[left] = elem
    end
  end

  # Insertion sort with a specified key selector.
  def insertionsort_by(&block)
    insertionsort { |ls, rs| yield(ls) < yield(rs) }
  end

  # Seletion sort with < comparison.
  def selectionsort
    selectionsort { |ls, rs| ls < rs }
  end

  # Selection sort with a specified less-than comparison.
  def selectionsort(&block)
    (size - 1).downto(1) do |right|
      acc = 0
      1.upto(right) { |left| acc = left if yield self[acc], self[left] }
      swap(acc, right)
    end
  end

  # Selection sort with a specified key selector.
  def selectionsort_by(&block)
    selectionsort { |ls, rs| yield(ls) < yield(rs) }
  end

  # Recursive top-down mergesort with < comparison.
  def mergesort
    mergesort { |ls, rs| ls < rs }
  end

  # Recursive top-down mergesort with a specified less-than comparison.
  def mergesort(&block : T, T -> B) forall B
    mergesort_subarray(Array(T).new(size), 0, size, &block)
  end

  # Recursive top-down mergesort with a specified key selector.
  def mergesort_by(&block : T -> K) forall K
    mergesort { |ls, rs| block.call(ls) < block.call(rs) }
  end

  private def mergesort_subarray(aux, low, high, &block : T, T -> U) forall U
    length = high - low
    return if length < 2

    mid = low + length // 2
    mergesort_subarray(aux, low, mid, &block)
    mergesort_subarray(aux, mid, high, &block)
    merge(aux, low, mid, high, &block)
  end

  private def merge(aux, low, mid, high, &block : T, T -> U) forall U
    left = low
    right = mid
    while left < mid && right < high
      if block.call(self[right], self[left])
        aux << self[right]
        right += 1
      else 
        aux << self[left]
        left += 1
      end
    end

    while left < mid
      aux << self[left]
      left += 1
    end

    raise "Bug: lost count in merge" unless right - low == aux.size
    self[low...right] = aux
    aux.clear
  end
end

a = (0..20).to_a
a.shuffle!
a2 = a.dup
a3 = a.dup

pp a
a.mergesort
pp a

puts
pp a2
a2.insertionsort
pp a2

puts
pp a3
a3.selectionsort
pp a3

puts
b = %w[foo bar baz quux foobar ham spam eggs speggs]
b2 = b.dup
b3 = b.dup

pp b
b.mergesort
pp b
b.mergesort_by &.size
pp b

puts
pp b2
b2.insertionsort
pp b2
b2.insertionsort_by &.size
pp b2

puts
pp b3
b3.selectionsort
pp b3
b3.selectionsort_by &.size
pp b3
