class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi # prepend self here
    greeting = greeting.new
    greeting.greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

Hello.hi
# If we call Hello.hi we get an error message. How would you fix this?

# We fix this by prepending the word self to the method name hi. This way we are making sure that we can calling a class method on the class directly without calling the instance method on an instance of the class.

# Also since we cannot simply call #greet in the #self.hi method because Greeting class itself only greet on its instances, we have to instantiate a new Greeting object within self.hi before calling the #greet method in Greeting.