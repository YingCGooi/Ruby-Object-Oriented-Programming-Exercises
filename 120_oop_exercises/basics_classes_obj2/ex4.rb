# Using the following code, add two methods: ::generic_greeting and #personal_greeting. The first method should be a class method and print a greeting that's generic to the class. The second method should be an instance method and print a greeting that's custom to the object.

class Cat
  attr_reader :name

  def self.speak # it makes sense to add class methods as generic actions for Cat.
    puts 'Meow!'
  end

  def self.generic_greeting
    # class methods only associated with the class itself, not with any instances of the class
    puts "Hello! I'm a cat!"
  end

  def personal_greeting
    puts "Hello! My name is #{name}"
  end

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
# Expected output:

# Hello! I'm a cat!
# Hello! My name is Sophie!
