module Shippable
  def ship
    "#{self.model} is being shipped to wonderland!"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model
  @@num_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@num_of_vehicles += 1
  end

  def self.calulate_mileage(gallons, miles)
    puts "#{(miles.to_f / gallons).round(2)} miles per gallon of gas"
  end

  def speed_up(number)
    @speed += number
    puts "You push the accelerator and speed up by #{number} mph."
  end

  def current_speed
    puts "You are now going #{self.speed} mph."
  end

  def self.display_n_vehicles
    puts "This program has created #{@@num_of_vehicles} number of vehicles"
  end

  def brake(number)
    @speed > number ? @speed -= number : @speed = 0
    puts "You pushed the brake slowed down by #{number} mph."
  end

  def shut_down
    @speed = 0
    puts "Let's park this car."
  end

  def age
    "Your #{self.model} is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  include Shippable
  WHEELS = 4
  DOORS = 4
  AXLES = 2
  CARGO = false

  def spray_paint(color)
    self.color = color
    puts "You have sprayed your car to #{color}!"
  end

  def to_s
    "My car is #{year}, has color #{color}, and the model #{model}"
  end
end

class MyTruck < Vehicle
  WHEELS = 8
  DOORS = 2
  AXLES = 4
  CARGO = true
end

my_car = MyCar.new(1994, "blue", "toyota")
my_truck = MyTruck.new(1998, "red", "Scania")
puts my_car.speed_up(25)
puts my_car.current_speed
puts my_car.brake(10)
puts my_truck.speed_up(27)
puts my_truck.current_speed
puts my_car.age
puts my_truck.age

puts my_car.ship
puts "---- Objects method lookup ----"
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors
Vehicle.display_n_vehicles