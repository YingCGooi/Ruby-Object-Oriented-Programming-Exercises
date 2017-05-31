# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices #override the choices method in superclass
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
# What is the result of the following:

trip = RoadTrip.new
p trip.predict_the_future
# "You will visit Vegas/ any other choices from RoadTrip class"
# Since we are calling #predict_the_future on an isntance of RoadTrip, it will call choices method in RoadTrip. Ruby will look for a definition of choices in the calling object.
# Every time Ruby tries to resolve a method name, it will start with the methods defined on the class you are calling.