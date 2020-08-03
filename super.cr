class Base
  def f(x)
    puts "Base#f(#{x})"
  end

  def f
    puts "Base#f()"
  end
end

class Derived < Base
  def f(x)
    puts "Derived#f(#{x})"
    super
    super()
  end
end

Derived.new.f(10)
