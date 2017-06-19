# You can write minilang programs that take input values by simply interpolating values into the program string with Kernel#format. For instance

CENTIGRADE_TO_FAHRENHEIT =
  '32 PUSH 5 PUSH 9 PUSH %<degrees_c>d MULT DIV ADD PRINT' # x * 9 / 5 + 32
MILES_PER_HOUR_TO_KM_PER_HOUR =
  '3 PUSH 5 PUSH %<mph>d MULT DIV PRINT'   # x * 5 / 3
AREA_OF_RECTANGLE =
  '%<length>d PUSH %<width>d MULT PRINT' # width * length


class MinilangRuntimeError < RuntimeError; end
class BadTokenError < MinilangRuntimeError; end
class EmptyStackError < MinilangRuntimeError; end

class Minilang
  MAX_NUM = 999_999_999
  ACTIONS = %w[PRINT PUSH POP ADD SUB MULT DIV MOD]

  def initialize(conversion)
    @stack = []
    @register = 0
    @conversion = conversion
  end

  def eval(val_to_be_converted = {})
    formatted = format(@conversion, val_to_be_converted)
    formatted.split.each do |command|
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



# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40
# This process could be simplified by passing some optional parameters to eval, and using those parameters to modify the program string.

# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40
# Try to implement this modification. Also, try writing other minilang programs, such as one that converts fahrenheit to centigrade, another that converts miles per hour to kilometers per hour (3 mph is approximately equal to 5 kph). Try writing a program that needs two inputs: for example, compute the area of a rectangle.

minilang2 = Minilang.new(MILES_PER_HOUR_TsO_KM_PER_HOUR)
minilang2.eval(mph: 40)
# 66
minilang2.eval(mph: 70)
# 116

minilang3 = Minilang.new(AREA_OF_RECTANGLE)
minilang3.eval(length: 80, width: 6)
# 480
minilang3.eval(length: 25, width: 41)
# 1025


