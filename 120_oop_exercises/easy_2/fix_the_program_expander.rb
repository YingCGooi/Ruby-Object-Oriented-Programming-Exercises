# What is wrong with the following code? What fix(es) would you make?

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3) # we cannot use the keyword self to call private instance methods. Private methods can never be called with an explicit receiver, even if the receiver is self.
  end

  private # unless we use protected here

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander