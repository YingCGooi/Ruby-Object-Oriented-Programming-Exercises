# Add the appropriate accessor methods to the following code.

class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica' # setter method #name=
puts person1.name
# Expected output:

# Jessica