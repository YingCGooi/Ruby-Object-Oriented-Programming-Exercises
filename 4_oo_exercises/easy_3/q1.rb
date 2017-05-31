# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
# What happens in each of the following cases:

# case 1:

hello = Hello.new
hello.hi # => "Hello"
# case 2:

hello = Hello.new
hello.bye # => NoMethodError, neither Hello nor Greeting have a #bye method defined.
# case 3:

hello = Hello.new
hello.greet # => ArgumentError, #greet method requires an argument to be passed into, which in this case is not supplied
# case 4:

hello = Hello.new
hello.greet("Goodbye") # => "Goodbye"
# case 5:

Hello.hi # => Undefined method - NoMethodError.
# This is because the #hi method is defined for instances of the #Hello class, rather than the class itself.
# In this case we are attempting to call #hi on #Hello class rather than an instance of the class, thus Ruby cannot find the method on the class definition.

