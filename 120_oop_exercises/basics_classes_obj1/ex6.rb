# Using the code from the previous exercise, move the greeting from the #initialize method to an instance method named #greet that prints a greeting when invoked.

class Cat
  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet # greet instance method is invoked here

# Expected output:

# Hello! My name is Sophie!

# Since kitty is an instance of the Cat class, if we add the #greet instance method, we are able to invoke it on kitty.