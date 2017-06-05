# Using the following code, determine the lookup path used when invoking bird1.color. Only list the classes or modules that were checked by Ruby when searching for the #color method.

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

color_method_class = bird1.method(:color).owner
p bird1_ancestors = bird1.class.ancestors
puts bird1_ancestors[0..bird1_ancestors.index(color_method_class)]