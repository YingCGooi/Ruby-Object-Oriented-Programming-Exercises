# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# we define our AngryCat(s), by passing in values to the class upon creation. These values will be assigned to instance variables on the class and make these two instances different.

oliver = AngryCat.new(0.7, "Oliver")
marty = AngryCat.new(1.2, "Martin")

# Ruby will call the initialize method when an object is created.
oliver.name
marty.name
oliver.age
marty.age

# They have two different set of object states from when they are created.


