# Using the following code, determine the lookup path used when invoking cat1.color. Only list the classes and modules that Ruby will check when searching for the #color method.

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
# cat1.color
p cat1.class.ancestors
# Kernel is a module
# Ruby searches for a possible color method in every class and module. The search path includes every possible classes and module since the color method is nowhere to be found.