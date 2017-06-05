# Using the following code, add a method named share_secret that prints the value of @secret when invoked.

class Person
  attr_writer :secret

  def share_secret
    puts secret # we can invoke the private method here.
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
p person1.secret rescue "private method called" # private methods can't be invoked from outside the class
person1.share_secret
# Expected output:

# Shh.. this is a secret!