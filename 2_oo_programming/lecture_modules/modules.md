### Multiple inheritance

Mix in becomes useful to multiple inheritance. If we want both dogs and fish to swim but not create the same methods in those classes, we can include the `Swim`module into the Class.

```ruby
module Swim
  def swim
    "swimming!"
  end
end

class Dog
  include Swim
  # ... rest of class omitted
end

class Fish
  include Swim
  # ... rest of class omitted
end
```
