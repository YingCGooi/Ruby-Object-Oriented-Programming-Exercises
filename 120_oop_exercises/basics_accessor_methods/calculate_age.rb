# Using the following code, multiply @age by 2 upon assignment, then multiply @age by 2 again when @age is returned by the getter method.

class Person
  def age=(age)
    # performing calc is convenient
    @age = double(age)
  end

  def age
    @age * 2
  end

  private
  # good idea to restrict calculations to be accessed within the class.
  def double(value)
    value * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age
# Expected output:

# 80