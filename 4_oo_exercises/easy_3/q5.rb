# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer # NoMethodError
tv.model

Television.manufacturer
Television.model # NoMethodError

# tv.manufacturer will raise a NoMethodError, since #manufacturer is a class method that can only be called by the class itself directly. tv.manufacturer implies that we are calling #manufacturer on an instance of that class.

# Television.model will raise a NoMethodError. This is because the method is only available at the point of instantiation, called by an instance of the class Television, in this case tv.

