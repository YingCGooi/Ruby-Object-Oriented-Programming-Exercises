# Using the following code, add the appropriate accessor methods. Keep in mind that @age should only be visible to instances of Person.

class Person
  attr_writer :age

  def older_than?(other)
    age > other.age
  end

  protected
  # instances of the class or a subclass can call the method, but not outside of the class
  attr_reader :age

  private
  # subclasses can access the method, not instances of the class
  def example
  end
end

class Boy < Person
  def call_example
    example
  end
end



person1 = Person.new
person1.age = 17

person2 = Person.new
person2.age = 26

puts person1.older_than?(person2)