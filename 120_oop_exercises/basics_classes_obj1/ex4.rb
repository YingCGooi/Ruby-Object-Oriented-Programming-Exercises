# Using the code from the previous exercise, add an #initialize method that prints I'm a cat! when a new Cat object is initialized.

class Cat
  def initialize
    puts "I'm a cat!"
  end
end

kitty = Cat.new
# Expected output:

# I'm a cat!

# defining an initialize method allows us to execute certain statements whenever a new Cat object is initialized (instantiated).