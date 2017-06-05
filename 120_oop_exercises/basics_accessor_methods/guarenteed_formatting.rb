# Using the following code, add the appropriate accessor methods so that @name is capitalized upon assignment.

class Person
  attr_reader :name

  def name=(name) # manually write the setter method
    @name = name.capitalize
    # format upon assignment
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name
# Expected output:

# Elizabeth
