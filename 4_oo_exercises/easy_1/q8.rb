# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# You can see in the make_one_year_older method we have used self. What does self refer to here?

# self refers to the object itself, in this case, a Cat object. When we call #age= on self, we are essentially calling the instance method #age= here.
# Note that it is only possible to call self.age when a Cat object is instantiated. self here is referencing the instance (object) that called #age - the calling object.
