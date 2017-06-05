# Modify the following code so that the value of @phone_number can't be modified outside the class.

class Person
  attr_reader :phone_number
  # prevent modification from outside of the class unless specified.

  def initialize(number)
    @phone_number = number
  end

end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number
# Expected output:

# 1234567899
# NoMethodError