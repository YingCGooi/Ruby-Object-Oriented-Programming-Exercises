# Continuing with our Person class definition, what does the below print out?

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

  def to_s
    name
  end

  private

  def parse_full_name(full_name)
    name_split = full_name.split
    self.first_name = name_split.first
    self.last_name = name_split.size > 1 ? name_split.last : ''
  end
end


bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# without writing the to_s method, it prints the memory address, since to_s instance method is called inherited from the Object class. If not, we have to manually call 'name' method.

# Now with the to_s method, puts should output "Robert Smith", since to_s is called on the bob object.