# Consider the following class definition:

class Flight
  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end

  private

  def database_handle
    @database_handle
  end
end
# There is nothing technically incorrect about this class, but the definition may lead to problems in the future. How can this class be fixed to be resistant to future problems?

# The instance variables @database_handle can be changed from outside of the class.
# by making access to @database_handle, someone may use it in real code.
# Once that database handle is being used in real code, future modifications to the class may break that code.