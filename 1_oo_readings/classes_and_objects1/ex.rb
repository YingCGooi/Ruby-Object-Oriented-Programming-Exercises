# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :color, :speed
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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

toyota = MyCar.new(1996, "blue", "Toyota")
toyota.current_speed
toyota.speed_up(25)
toyota.current_speed
toyota.brake(28)
toyota.current_speed
toyota.color = 'red'
puts toyota.color
puts toyota.year
toyota.spray_paint('yellow')