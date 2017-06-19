class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def show_switch_state
    switch
  end

  private

  attr_accessor :switch

  # we don't want to expose certain methods to the users of this code.
  def flip_switch(desired_state)
    self.switch = desired_state # self is the receiver here
    # if you remove the receiver, ruby will create a local variable named switch.
  end
end
# Modify this class so both flip_switch and the setter method switch= are private methods.

machine = Machine.new
machine.stop
machine.start
p machine.show_switch_state