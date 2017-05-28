# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

class Person
  attr_accessor :last_name, :first_name

  def initialize(full_name)
    name_split = full_name.split
    @first_name = name_split.first
    @last_name = name_split.size > 1 ? name_split.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end


p bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'