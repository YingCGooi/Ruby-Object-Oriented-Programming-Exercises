# Using the code from the previous exercise, add a getter method named #name and invoke it in place of @name in #greet.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!" # getter method #name is invoked here.
  end
end

kitty = Cat.new('Sophie')
kitty.greet
# we can also invoke the getter method outside of the class via the object:
p kitty.name # => "Sophie"