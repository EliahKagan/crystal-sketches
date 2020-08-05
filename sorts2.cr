# Various sorting algorithms for arrays.
class Array(T)
  # Insertion sort with <=> comparison.
  def insertionsort
    insertionsort { |ls, rs| ls <=> rs }
  end

  # Insertion sort with a specified <=>-like comparison.
  def insertionsort(&block)
    1.upto(size - 1) do |right|
      elem = self[right]

      left = right
      while left > 0 && yield(elem, self[left - 1]) < 0
        self[left] = self[left - 1]
        left -= 1
      end

      self[left] = elem
    end
  end

  # Insertion sort with a specified key selector.
  def insertionsort_by(&block)
    insertionsort { |ls, rs| yield(ls) <=> yield(rs) }
  end

  # Seletion sort with <=> comparison.
  def selectionsort
    selectionsort { |ls, rs| ls <=> rs }
  end

  # Selection sort with a specified <=>-like comparison.
  def selectionsort(&block)
    (size - 1).downto(1) do |right|
      acc = 0
      1.upto(right) { |left| acc = left if yield(self[acc], self[left]) < 0 }
      swap(acc, right)
    end
  end

  # Selection sort with a specified key selector.
  def selectionsort_by(&block)
    selectionsort { |ls, rs| yield(ls) <=> yield(rs) }
  end

  # Recursive top-down mergesort with <=> comparison.
  def mergesort
    mergesort { |ls, rs| ls <=> rs }
  end

  # Recursive top-down mergesort with a specified <=>-like comparison.
  def mergesort(&block : T, T -> B) forall B
    mergesort_subarray(Array(T).new(size), 0, size, &block)
  end

  # Recursive top-down mergesort with a specified key selector.
  def mergesort_by(&block : T -> K) forall K
    mergesort { |ls, rs| block.call(ls) <=> block.call(rs) }
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
      if block.call(self[right], self[left]) < 0
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

  # Heapsort with <=> comparison.
  def heapsort
    heapsort { |ls, rs| ls <=> rs }
  end

  # Heapsort with a specified <=>-like comparison.
  def heapsort(&block)
    return if size < 2

    maxheapify { |ls, rs| yield(ls, rs) }

    size.downto(2) do |heap_size|
      maxheap_pop_inplace(heap_size) { |ls, rs| yield(ls, rs) }
    end
  end

  # Heapsort with a specified key selector.
  def heapsort_by(&block)
    heapsort { |ls, rs| yield(ls) <=> yield(rs) }
  end

  private def maxheapify(&block)
    (size // 2 - 1).downto(0) do |parent|
      maxheap_sift_down(parent, size) { |ls, rs| yield(ls, rs) }
    end
  end

  private def maxheap_pop_inplace(heap_size, &block)
    swap(0, heap_size - 1)
    maxheap_sift_down(0, heap_size - 1) { |ls, rs| yield(ls, rs) }
  end

  private def maxheap_sift_down(parent, heap_size, &block)
    elem = self[parent]

    loop do
      child = maxheap_pick_child(parent, heap_size) { |ls, rs| yield(ls, rs) }
      break unless child && yield(elem, self[child]) < 0
      self[parent] = self[child]
      parent = child
    end

    self[parent] = elem
  end

  private def maxheap_pick_child(parent, heap_size, &block)
    left = parent * 2 + 1
    return nil if left >= heap_size
    right = left + 1
    right == heap_size || yield(self[right], self[left]) < 0 ? left : right
  end

  # Quicksort with <=> comparison.
  def quicksort
    quicksort { |ls, rs| ls <=> rs }
  end

  # Quicksort with a specified <=>-like comparison.
  def quicksort(&block : T, T -> B) forall B
    quicksort_subarray(0, size, &block)
  end

  # Quicksort with a specified key selector.
  def quicksort_by(&block : T -> K) forall K
    quicksort { |ls, rs| block.call(ls) <=> block.call(rs) }
  end

  private def quicksort_subarray(low, high, &block : T, T -> B) forall B
    return if high - low < 2
    mid = lomuto_partition(low, high, &block)
    quicksort_subarray(low, mid, &block)
    quicksort_subarray(mid + 1, high, &block)
  end

  private def lomuto_partition(low, high, &block : T, T -> B) forall B
    swap(low, low + (high - low) // 2)
    pivot = self[low]

    left = low
    (low + 1).upto(high - 1) do |right|
      swap(left += 1, right) if yield(self[right], pivot) < 0
    end

    swap(low, left)
    left
  end
end

a = (0..20).to_a
a.shuffle!
a2 = a.dup
a3 = a.dup
a4 = a.dup
a5 = a.dup

puts "Merge sort:"
pp a
a.mergesort
pp a
puts

puts "Insertion sort:"
pp a2
a2.insertionsort
pp a2
puts

puts "Selection sort:"
pp a3
a3.selectionsort
pp a3
puts

puts "Heap sort:"
pp a4
a4.heapsort
pp a4
puts

puts "Quicksort:"
pp a5
a5.quicksort
pp a5
puts

b = %w[foo bar baz quux foobar ham spam eggs speggs]
b2 = b.dup
b3 = b.dup
b4 = b.dup
b5 = b.dup

puts "Merge sort:"
pp b
b.mergesort
pp b
b.mergesort_by &.size
pp b
puts

puts "Insertion sort:"
pp b2
b2.insertionsort
pp b2
b2.insertionsort_by &.size
pp b2
puts

puts "Selection sort:"
pp b3
b3.selectionsort
pp b3
b3.selectionsort_by &.size
pp b3
puts

puts "Heap sort:"
pp b4
b4.heapsort
pp b4
b4.heapsort_by &.size
pp b4
puts

puts "Quicksort:"
pp b5
b5.quicksort
pp b5
b5.quicksort_by &.size
pp b5
