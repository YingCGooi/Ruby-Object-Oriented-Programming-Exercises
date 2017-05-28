# Using the class definition from step #3, let's create a few more people -- that is, Person objects.

class Person
  attr_accessor :last_name, :first_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    name_split = full_name.split
    self.first_name = name_split.first
    self.last_name = name_split.size > 1 ? name_split.last : ''
  end
end

p bob = Person.new('Robert Smith')
p rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

# we can call the 'name' method on both objects to determine if they are the same using == comparison operator.

p bob.name == rob.name
