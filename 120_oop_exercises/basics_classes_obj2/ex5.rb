# Using the following code, create a class named Cat that tracks the number of times a new Cat object is instantiated. The total number of Cat instances should be printed when #total is invoked.

class Cat
  @@num_of_cats = 0 # handled by the class itself rather than instances of the class. Every instances of the class will share only one copy of the class variable.

  def initialize
    # tracks the number of Cat objects being instantiated
    @@num_of_cats += 1
  end

  def self.total
    puts @@num_of_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

Cat.total
# Expected output:

# 2