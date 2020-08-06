# Various sorting algorithms for arrays.
class Array(T)
  # Insertion sort with <=> comparison.
  def insertionsort
    insertionsort { |ls, rs| ls <=> rs }
  end

  # Insertion sort with a specified <=>-like comparison.
  def insertionsort(&block)
    1.upto(size - 1) do |right|
      right.downto(1) do |left|
        break unless yield(self[left], self[left - 1]) < 0
        swap(left, left - 1)
      end
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
    aux = Array(T).new(size)

    merge = ->(low : Int32, mid : Int32, high : Int32) do
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

    mergesort_subarray = ->(low : Int32, high : Int32) { }
    mergesort_subarray = ->(low : Int32, high : Int32) do
      length = high - low
      return if length < 2

      mid = low + length // 2
      mergesort_subarray.call(low, mid)
      mergesort_subarray.call(mid, high)
      merge.call(low, mid, high)
    end

    mergesort_subarray.call(0, size)
  end

  # Recursive top-down mergesort with a specified key selector.
  def mergesort_by(&block : T -> K) forall K
    mergesort { |ls, rs| block.call(ls) <=> block.call(rs) }
  end

  # Heapsort with <=> comparison.
  def heapsort
    heapsort { |ls, rs| ls <=> rs }
  end

  # Heapsort with a specified <=>-like comparison.
  def heapsort(&block : T, T -> I) forall I
    heap_size = size
    return if heap_size < 2

    pick_child = ->(parent : Int32) do
      left = parent * 2 + 1
      return nil if left >= heap_size

      right = left + 1
      if right == heap_size || block.call(self[right], self[left]) < 0
        left
      else
        right
      end
    end

    sift_down = ->(parent : Int32) do
      loop do
        child = pick_child.call(parent)
        break unless child && block.call(self[parent], self[child]) < 0
        swap(parent, child)
        parent = child
      end
    end

    # Convert the array into a maxheap.
    (heap_size // 2 - 1).downto(0, &sift_down)

    # Pop each item to the end of the heap.
    while (heap_size -= 1) > 0
      swap(0, heap_size)
      sift_down.call(0)
    end
  end

  # Heapsort with a specified key selector.
  def heapsort_by(&block : T -> K) forall K
    heapsort { |ls, rs| block.call(ls) <=> block.call(rs) }
  end

  # Quicksort with <=> comparison.
  def quicksort
    quicksort { |ls, rs| ls <=> rs }
  end

  # Quicksort with a specified <=>-like comparison.
  def quicksort(&block : T, T -> I) forall I
    lomuto_partition = ->(low : Int32, high : Int32) do
      swap(low, low + (high - low) // 2)
      pivot = self[low]

      left = low
      (low + 1).upto(high - 1) do |right|
        swap(left += 1, right) if block.call(self[right], pivot) < 0
      end

      swap(low, left)
      left
    end

    quicksort_subarray = ->(low : Int32, high : Int32) { }
    quicksort_subarray = ->(low : Int32, high : Int32) do
      return if high - low < 2
      mid = lomuto_partition.call(low, high)
      quicksort_subarray.call(low, mid)
      quicksort_subarray.call(mid + 1, high)
    end

    quicksort_subarray.call(0, size)
  end

  # Quicksort with a specified key selector.
  def quicksort_by(&block : T -> K) forall K
    quicksort { |ls, rs| block.call(ls) <=> block.call(rs) }
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
