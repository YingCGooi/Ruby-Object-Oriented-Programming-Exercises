# Let's create a few more methods for our Dog class.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end

  def speak
    'bark!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

p pete = Pet.new
p kitty = Cat.new
p dave = Dog.new
p bud = Bulldog.new

p pete.run                # => "running!"
p pete.speak              # => p NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
kitty.fetch             # => p NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"