# Using the following code, add the appropriate accessor methods so that @name is returned with the added prefix 'Mr.'.

class Person
  attr_writer :name

  def name # manually implement a getter method
    "Mr. " + @name
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name
# Expected output:

# Mr. James