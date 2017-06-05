# Complete this program so that it produces the expected output:

class Book
  attr_reader :title, :author

  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)
# Expected output:

# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration

# attr_reader creates a getter method which allow users to retrieve the instance variables' return vlaue
# attr_writer creates a setter method which allow users to set a new value to the instance variable
# we use attr_reader because in this case we are only retrieving the value of the instance variables.

def title
  @title
end

def author
  @author
end
 # it will not change the behavior of the class in any way.
 # the advantages of this code is that is allows manipulation on the instance variables before returning or setting a value from the getter methods, for example if we want to output a capitalized version of the string and keep the original, we have to use the longhand way of writing getter methods.