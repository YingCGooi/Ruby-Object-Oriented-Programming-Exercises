# Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.

class Cat
  def self.generic_greeting
  # class method definition
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting # we are able to invoke a Cat class method without instantiating a Cat object.
# Expected output:

# Hello! I'm a cat!

# if we happend to invoke a class method on an instance of the class, we will get a NoMethodError.

kitty = Cat.new
kitty.class.generic_greeting
# outputs the same result. This is because calling #class on kitty returns the class of the calling object - Cat class itself.
# when we call the class method #generic_greeting on the return value (Cat class) it will output the same result.