# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color
  # they add potential value as we can alter brightness and color outside the Light class

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    # return
    "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

# the return keyword in the information method is not necessary. Ruby automatically returns the last evaluated statement of any method, so we can remove the return keyword.
