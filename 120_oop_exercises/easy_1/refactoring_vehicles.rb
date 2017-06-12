# Consider the following classes:
class Vehicle
  attr_reader :make, :model

  def initialize(make, model) # can take additional parameter wheels here
    @make = make
    @model = model
    # @wheels = wheels
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  # def initialize(make, model)
  #   super(make, model, 4)
  # end
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
  # def initialize(make, model)
  #   super(make, model, 2)
  # end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model) # super(make, model, 6)
    @payload = payload
  end

  def wheels
    6
  end
end
# Refactor these classes so they all use a common superclass, and inherit behavior as needed.

# Would it make sense to define a wheels method in Vehicle even though all of the remaining classes would be overriding it? Why or why not? If you think it does make sense, what method body would you write?

# It is a good idea to include a @wheels instance variable within the Vehicles class.