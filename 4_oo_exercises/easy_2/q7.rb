# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
    puts "cats_count #{@@cats_count}"
  end

  def self.cats_count
    @@cats_count
  end
end
# Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

# The @@cats_count is a class variable and it is supposed to keep track of how many cat instances have been created.

#

p Cat.cats_count
p Cat.new('gray tabby')
# during the object instantiation process it will call the #initialize method and thus incrementing the value of @@cats_count variable
p Cat.new('white furry')
p Cat.cats_count