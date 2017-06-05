# Using the following code, create a module named Walkable that contains a method named #walk. This method should print Let's go for a walk! when invoked. Include Walkable in Cat and invoke #walk on kitty.

module Walkable
# modules contain methods useful of multiple classes
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  # mix in a module, allowing class Cat to invoke the contained methods.
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.walk
# Expected output:

# Hello! My name is Sophie!
# Let's go for a walk!