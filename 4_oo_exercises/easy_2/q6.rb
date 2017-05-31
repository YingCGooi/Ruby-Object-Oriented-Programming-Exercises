class Television
  def initialize
    @value = 'Hello'
  end

  def self.manufacturer # this is a class method
    @value = 'TV'
  end

  def model
    @value
  end
end

# a class method has a self prepended on the method name
# class methods can be called without instantiating the class.

p Television.manufacturer
tv = Television.new
p tv.model