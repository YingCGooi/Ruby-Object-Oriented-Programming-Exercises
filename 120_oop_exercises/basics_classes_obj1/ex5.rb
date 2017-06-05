# Using the code from the previous exercise, add a parameter to #initialize that provides a name for the Cat object. Use an instance variable to print a greeting with the provided name. (You can remove the code that displays I'm a cat!.)

class Cat
  def initialize(name)
    @name = name # initialization of new instance var
    # @name is now available to reference anywhere inside the object.
    puts "Hello! My name is #{@name}!" # instance var @name is referenced here.
  end
end

kitty = Cat.new('Sophie')
# Expected output:

# Hello! My name is Sophie!

