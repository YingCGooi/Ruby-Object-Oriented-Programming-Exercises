# Update the following code so that it prints I'm Sophie! when it invokes puts kitty.

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s # override the built-in to_s method
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty # to_s instance method is called here on the first found class in the method lookup path
# Expected output:

# I'm Sophie!