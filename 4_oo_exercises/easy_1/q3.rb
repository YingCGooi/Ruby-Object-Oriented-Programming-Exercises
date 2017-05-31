# When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

# self refers to the object itself.
# calling #class on self returns the class name of the object.
# The string interpolation calls to_s, which converts the class name to a string.