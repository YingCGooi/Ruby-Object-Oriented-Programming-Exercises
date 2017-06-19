# Below we have 3 classes: Student, Graduate, and Undergraduate. Some details for these classes are missing. Make changes to the classes below so that the following requirements are fulfilled:

# Graduate students have the option to use on-campus parking, while Undergraduate students do not.

# Graduate and Undergraduate students have a name and year associated with them.

# Note, you can do this by adding or altering no more than 5 lines of code.

class Student
  def initialize(name = 'N/A', year = 0000) # set default values here so that super() can be called by sub-classes
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year) # specify the arguments we wish to pass to Student#initialize by explicitly passing those arguments to super.
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super # calls a method further up the inheritance chain that has the same name as enclosing method, passing in all arguments specified in the enclosing method.
  end
end

# further exploration

class Placeholder < Student
  def initialize
    super() # keep track of number of empty spots in a college class
  end
end

placeholder = Placeholder.new