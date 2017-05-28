# Class based inheritance works great when it's used to model hierarchical domains. Let's take a look at a few exercises. Suppose we're building a software system for a pet hotel business, so our classes deal with pets.

# Given this class:

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

karl = Bulldog.new
puts karl.speak
puts karl.swim

# One problem is that we need to keep track of different breeds of dogs, since they have slightly different behaviors. For example, bulldogs can't swim, but all other dogs can.

# Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"