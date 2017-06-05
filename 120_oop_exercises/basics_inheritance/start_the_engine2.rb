# Given the following code, modify #start_engine in Truck by appending 'Drive fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in 'Drive fast, please!' should be the value of speed.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    @speed = speed
    super() + " Drive #{speed}, please"
    # calling super() will return 'Ready to go' from the superclass. Thus, we just need to concatenate the remaining of the sentence into return value of superclass method start_engine.
    # we need to specify the number of args being passed into superclass start_engine, which in this case is 0. Therefore, we append () empty parentheses to super keyword.
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
# Expected output:

# Ready to go! Drive fast, please!