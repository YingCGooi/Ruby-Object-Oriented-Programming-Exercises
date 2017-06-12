# Correct the following program so it will work properly. Assume that the Car class has a complete implementation; just make the smallest possible change to ensure that cars have access to the drive method.

module Drivable
  def drive # if self is written here, the method will not be available at all as an instance method to objects
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive