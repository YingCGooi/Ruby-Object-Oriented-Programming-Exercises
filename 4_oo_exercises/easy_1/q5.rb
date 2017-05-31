# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name # name is local variable
    # since we didn't write getter or setter methods, name is initialized as a local variable
  end
end

class Pizza
  def initialize(name)
    @name = name # @name is instance variable
  end
end

# instance variables have @ symbol in front of the variable name.

p my_pizza = Pizza.new('vege')
p my_fruit = Fruit.new('pineapple')

# we can call the instance_variables method on the instance of the class to output all available instance variables and what they are.
p my_pizza.instance_variables
p my_fruit.instance_variables