# Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes that were checked by Ruby when searching for the #color method.

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
color_method_class = cat1.method(:color).owner
# the class in which the instance method #color is invoked
p cat_ancestors = cat1.class.ancestors
# list of all ancestors of cat1 object
puts cat_ancestors[0..cat_ancestors.index(color_method_class)]
# outputs the method lookup path, up to the class where the instance method #color is invoked.

# Ruby searches a method's class for the specified method when it is invoked. If no method is found in the current class, Ruby inspects the class' superclass.