# n Place a value n in the "register". Do not modify the stack.
# PUSH Push the register value on to the stack. Leave the value in the register.
# ADD Pops a value from the stack and adds it to the register value, storing the result in the register.
# SUB Pops a value from the stack and subtracts it from the register value, storing the result in the register.
# MULT Pops a value from the stack and multiplies it by the register value, storing the result in the register.
# DIV Pops a value from the stack and divides it into the register value, storing the integer result in the register.
# MOD Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
# POP Remove the topmost item from the stack and place in register
# PRINT Print the register value
class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  MAX_NUM = 999_999_999
  ACTIONS = %w[PRINT PUSH POP ADD SUB MULT DIV MOD]

  def initialize(commands)
    @stack = []
    @register = 0
    @commands = commands
  end

  def eval
    @commands.split.each do |command|
      begin
        raise_bad_token_error(command) unless valid?(command)
        evaluate(command)
      rescue MinilangRuntimeError => error
        puts error.message
      end
    end
  end

  def raise_bad_token_error(command)
    raise(BadTokenError, "Invalid token: #{command}")
  end

  def evaluate(command)
    return register_val(command) if is_number_str?(command)
    send(command.downcase)
  end

  def valid?(command)
    ACTIONS.include?(command) || is_number_str?(command)
  end

  def is_number_str?(command)
    command.to_i.to_s == command
  end

  def print
    raise(EmptyStackError, 'Empty stack!') if @register.nil?
    puts @register
  end

  def push;  @stack << @register       end
  def pop;   @register = @stack.pop    end
  def add;   @register += @stack.pop   end
  def sub;   @register -= @stack.pop   end
  def mult;  @register *= @stack.pop   end
  def div;   @register /= @stack.pop   end
  def mod;   @register %= @stack.pop   end

  def register_val(command)
    @register = command.to_i
  end
end

Minilang.new('PRINT').eval
# 0

mini = Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)