# Various sorting algorithms for arrays.
class Array(T)
  # Recursive top-down mergesort with < comparison.
  def mergesort
    mergesort { |ls, rs| ls < rs }
  end

  # Recursive top-down mergesort with a specified less-than comparison.
  def mergesort(&block)
    mergesort_subarray(Array(T).new(size), 0, size) { |ls, rs| yield ls < rs }
  end

  private def mergesort_subarray(aux, low, high, &block)
    length = high - low
    return if length < 2

    mid = low + length // 2
    mergesort_subarray(aux, low, mid) { |ls, rs| yield ls, rs }
    mergesort_subarray(aux, mid, high) { |ls, rs| yield ls, rs }
    merge(aux, low, mid, high) { |ls, rs| yield ls, rs }
  end

  private def merge(aux, low, mid, high, &block)
    left = low
    right = mid
    while left < mid && right < high
      if yield self[right], self[left]
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
pp a
a.mergesort
pp a
