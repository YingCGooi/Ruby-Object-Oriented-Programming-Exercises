# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def initialize # write an initialize method
    hiss
  end

  def hiss
    puts "Hisssss!!!"
  end
end

my_cat = AngryCat.new # creates a new instance of AngryCat class