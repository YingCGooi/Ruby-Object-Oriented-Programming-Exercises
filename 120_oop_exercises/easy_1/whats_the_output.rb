class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # returns a new string object. Does not refer to the same object name refers to.
  end

  def to_s
    # we don't want to mutate @name here
    "My name is #{@name.upcase}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

name = 42
fluffy = Pet.new(name)
name += 1 # local variable name is reassigned here, returning a new object for name.
p fluffy.name
p fluffy
p fluffy.name
p name # => 43