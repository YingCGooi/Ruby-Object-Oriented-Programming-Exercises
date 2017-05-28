### Class Methods

We can call class methods directly on the class itself, without having to instantiate any objects.

```ruby
# good_dog.rb
# ... rest of code ommitted for brevity

def self.what_am_i         # Class method definition
  "I'm a GoodDog class!"
end
```

We prepend the method name with the reserved word `self.`.

Then we call the class method, by using the class name `GoodDog` followed by the method name, without instantiating any objects.

```
GoodDog.what_am_i          # => I'm a GoodDog class!
```

Object contain state, and if we have a method that does not need to deal with states, then we can just use a class method.


### Class Variables

We can create class variables by putting `@@` in front of a variable. Class variables belong to a class, not an object.

```ruby
class GoodDog
  @@number_of_dogs = 0 #initialization

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs   # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs   # => 2
```

We can access class variables from within an instance method. We can return the value of the class variable directly by calling `self.total_number_of_dogs`. Class variables are shared throughout every instance of the objects, while instance methods only available within EACH object.

### Constants

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n # reassign the instance variable @name within #name setter method
    self.age  = a * DOG_YEARS # can be accessed here
  end
end

sparky = GoodDog.new("Sparky", 4)
puts sparky.age  # we call age getter method       # => 28
```

### to_s method
```
puts sparky      # => #<GoodDog:0x007fe542323320>
```

`puts` automatically calls `to_s` on its args, in this case the `sparky` object.

#### overriding to_s method

```ruby
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    @name = n
    @age  = a * DOG_YEARS
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end
end
```

```
puts sparky      # => This dog's name is Sparky and is 28 in dog years.
```

```
p sparky         # => #<GoodDog:0x007fe54229b358 @name="Sparky", @age=28>
```

`p` is very similar to `puts`, except it doesn't call `to_s`, instead it calls `inspect`. We want to make sure that we don't override it.

String interpolation `"#{}"` automatically calls `to_s`.

### Self

We can use `self` when:
- calling setter methods from within the class. This differentiates between initialzing a local variable and calling a setter method
- using `self` for class method definitions

```ruby
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self # returns the calling object
  end
end
```


```ruby
sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
 # => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
 ```

`def self.a_method` is the same as `def GoodDog.a_method`

- `self` inside of an instance method, references the instance (object) that called the method - the calling object. `self.weight=` is the same as `sparky.weight=`. This calls the setter method `weight=` within the class.

- `self` outside of an instance method, references the class and can be used to define class methods. Therefore, `def self.name=(n)` is the same as `def GoodDog.name=(n)`

