# Using the following code, add an instance method named compare_secret that compares the value of @secret from person1 with the value of @secret from person2.

class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret # calling other_person.secret will raise an error if it is a private method
    # protected methods allow access between different class instances, while private methods don't
    # protected methods allow for controlled, wider access between the class, accessed within a class.
  end

  protected # change this to private
  # private only allows closed access within the class, which means that attempts to call a private method from another class instance will cause Ruby to raise an error.

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)