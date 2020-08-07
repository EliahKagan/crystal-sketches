abstract class Animal
  abstract def talk
end

class Cat < Animal
  def talk
    puts "Meow!"
  end
end

class Dog < Animal
  def talk
    puts "Arf!"
  end
end

class Horse < Animal
  def talk
    puts "Neigh!"
  end
end

a = [] of Animal
a << Cat.new
a << Dog.new
puts "#{typeof(a)} #{a.class}"
a.each &.talk
puts

b = [Cat.new, Dog.new]
b << Horse.new
puts "#{typeof(b)} #{b.class}"
b.each &.talk
puts

puts "#{typeof(a)} == #{typeof(b)} == #{Array(Animal)}?  #{typeof(a) == typeof(b) == Array(Animal)}"
puts "#{Cat | Dog} == #{Animal}?  #{Cat | Dog == Animal}"
puts "#{Array(Cat | Dog)} == #{Array(Animal)}?  #{Array(Cat | Dog) == Array(Animal)}"
