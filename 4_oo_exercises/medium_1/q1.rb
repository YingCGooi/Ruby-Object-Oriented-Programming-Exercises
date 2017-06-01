# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
# Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the @ before balance when you refer to the balance instance variable in the body of the positive_balance? method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?

# Ben is right, since we already initialized a #balance getter method using attr_reader.
# By evaluating balance within the method body of #positive_balance? we are actually calling the balance getter method, which returns the value of @balance. This return value is then compared with 0 using the >= operator.
# If Ben had ommited the attr_reader, Alyssa would be right.

