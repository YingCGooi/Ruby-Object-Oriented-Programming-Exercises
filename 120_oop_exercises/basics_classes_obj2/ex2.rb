# Using the following code, add an instance method named #rename that renames kitty when invoked.

class Cat
  attr_accessor :name

  def rename(new_name)
    self.name = new_name # setter method for @name is invoked here, passing in new_name as an argument.
    # to modify a value using setter method, we must prepend self word so that Ruby knows the difference between initializing a local variable and inoking a setter method.
  end

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
p kitty.name
kitty.rename('Chloe')
p kitty.name
# Expected output:

# Sophie
# Chloe