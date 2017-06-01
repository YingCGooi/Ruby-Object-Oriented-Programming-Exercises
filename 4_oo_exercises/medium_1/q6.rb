# If we have these two methods:

# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231" # instance variable is directly accessed here
#   end

#   def show_template
#     template # #template getter method is called
#   end
# end
# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" # the #template setter method is called
  end

  def show_template
    self.template # the #template getter method is called. self isn't required here.
  end
end
# What is the difference in the way the code works?

a_computer = Computer.new
a_computer.create_template
p a_computer.show_template