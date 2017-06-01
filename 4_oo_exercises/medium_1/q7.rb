# How could you change the method name below so that the method name is more clear and less repetitive.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.desired_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

# previously when we call the class method, we would call it like this: Light.light_information
# Having the word 'light' to appear twice is redundant.
# changing the class method name to desired_information makes it read better when invoking the class method, like this: Light.desired_information