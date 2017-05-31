# What could we add to the class below to access the instance variable @volume?

class Cube
  attr_reader :volume # add a getter method to enable access

  def initialize(volume)
    @volume = volume
  end
end

my_cube = Cube.new(1000)
p my_cube.instance_variables
p my_cube.instance_variable_get("@volume")
p my_cube.volume