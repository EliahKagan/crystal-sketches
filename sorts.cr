# Various sorting algorithms for arrays.
class Array(T)
  # Recursive top-down mergesort with < comparison.
  def mergesort
    mergesort { |ls, rs| ls < rs }
  end

  # Recursive top-down mergesort with a specified less-than comparison.
  def mergesort(&block : T, T -> U) forall U
    mergesort_subarray(Array(T).new(size), 0, size, &block)
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
pp a
a.mergesort
pp a