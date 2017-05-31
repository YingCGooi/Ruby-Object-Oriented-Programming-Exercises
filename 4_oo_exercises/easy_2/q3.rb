# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors
p HotSauce.ancestors
# list of ancestors is also called a lookup chain.
# Ruby will look for a method starting the calling object, and eventually the BasicObject if the method is found nowhere in the lookup chain.

# If no method is found in the lookup chain, a NoMethodError will be raised.

# if you call this method on an instance of a class, it will not work.