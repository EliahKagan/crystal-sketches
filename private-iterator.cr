class Outer
  include Iterable(Int32)
  
  def initialize
    @inner = Inner.new
  end
  
  def each
    TrivialIterator.new(@inner)
  end
  
  private class TrivialIterator
    include Iterator(Int32)
    
    def initialize(@inner : Inner)
    end
    
    def next
      stop
    end
  end
  
  private class Inner
  end
end

ou = Outer.new
it = ou.each
pp it
pp it.to_a
