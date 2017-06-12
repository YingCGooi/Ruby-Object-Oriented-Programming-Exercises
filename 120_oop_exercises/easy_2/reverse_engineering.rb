# Write a class that will display:

# ABC
# xyz
# when the following code is run:

class Transform
  def initialize(str)
    @string = str
  end

  def uppercase
    @string.upcase # we use @string as a receiver
  end

  def self.lowercase(str) # class methods do not have access to instance variables #lowercase must obtain the string to convert from some source other than an isntance variable
    str.downcase
  end
end
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')