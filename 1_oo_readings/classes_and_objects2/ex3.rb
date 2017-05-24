# ex3.rb

# When running the following code...

class Person
  attr_accessor(:name)
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
p bob.name
# We get the following error...

# test.rb:9:in `<main>': undefined method `name=' for
#   #<Person:0x007fef41838a28 @name="Steve"> (NoMethodError)

# Why do we get this error and how to we fix it?

# In our class, we used the method attr_method, passing in :name as an argument. This creates a getter method with respect to the instance variable @name. However we did not create a setter method or use attr_accessor/attr_writer, therefore we can only get the value of @name but we cannot modify it from outside the class.
# We can fix this by changing attr_reader to attr_writer/attr_accessor
