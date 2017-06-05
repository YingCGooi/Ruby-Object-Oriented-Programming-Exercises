# Create a module named Transportation that contains three classes: Vehicle, Truck, and Car. Truck and Car should both inherit from Vehicle.

module Transportation
  # useful for namespacing
  class Vehicle
  end

  class Truck < Vehicle
  end

  class Car < Vehicle
  end
end

# Namespacing is where similar classes are grouped within a module.
my_truck = Transportation::Truck.new