# Using the code from the previous exercise, replace the getter and setter methods using Ruby shorthand.

class Cat
  attr_accessor: name # is convenient so that we can both retrieve the name and change it.

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{name}!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
kitty.name = 'Luna'
kitty.greet
# Expected output:

# Hello! My name is Sophie!
# Hello! My name is Luna!

