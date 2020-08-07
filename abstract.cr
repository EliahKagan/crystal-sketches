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

a = [] of Animal
a << Cat.new
a << Dog.new
a.each &.talk
