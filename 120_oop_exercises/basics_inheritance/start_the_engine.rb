# Modify the following code so that #start_engine is invoked upon initialization of truck1.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year) # overrides the super class (Vehicle)'s initialize method
    super # preserve the functionality of the super class' method, passing in all arguments passed in to sub-class initialize method.
    start_engine
  end

  def start_engine
    'Ready to go!'
  end
end

puts Truck.ancestors
truck1 = Truck.new(1994)
puts truck1.year
# Expected output:

# Ready to go!
# 1994