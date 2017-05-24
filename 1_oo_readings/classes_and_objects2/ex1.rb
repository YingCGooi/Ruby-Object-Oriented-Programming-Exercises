# Add a class method to your MyCar class that calculates the gas mileage of any car.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.calulate_mileage(gallons, miles)
    puts "#{(miles.to_f / gallons).round(2)} miles per gallon of gas"
  end

  def speed_up(number)
    @speed += number
    puts "You push the accelerator and speed up by #{number} mph."
  end

  def current_speed
    puts "You are now going #{speed} mph."
  end

  def brake(number)
    @speed > number ? @speed -= number : @speed = 0
    puts "You pushed the brake slowed down by #{number} mph."
  end

  def shut_down
    @speed = 0
    puts "Let's park this car."
  end

  def spray_paint(color)
    self.color = color
    puts "You have sprayed your car to #{color}!"
  end
end

MyCar.calulate_mileage(19, 23)
