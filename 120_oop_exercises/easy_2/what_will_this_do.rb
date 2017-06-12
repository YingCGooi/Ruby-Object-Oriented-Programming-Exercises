# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata # instance method
    @data + @data
  end

  def self.dupdata # class method
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata # => 'ByeBye' # calls the class method
puts thing.dupdata # => 'HelloHello'

