# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# In the name of the cats_count method we have used self. What does self refer to in this context?

# self here refers to the calling object, which the class itself. When we put it in a definition, it becomes a class method, which means that it can be called without an instantiation of the class object.

p oliver = Cat.new('gray tabby')
p darci = Cat.new('white furry')
p Cat.cats_count