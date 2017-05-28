### Collaborator Objects

The state of an object is usually in the form of a string or number.

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name # @name holds a string object
  end
end

joe = Person.new("Joe") #since "Joe" is an object of the String class
joe.name                    # => "Joe"
```


Instance variables can hold strings, integers, arrays or hashes.


### Nesting objects 

```ruby
class Person
  attr_accessor :name, :pet

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Robert")
bud = Bulldog.new             # assume Bulldog class from previous assignment

bob.pet = bud # set bob's @pet instance variable to bud, which is a Bulldog object.
```

We can also chain `Bulldog` methods at the end:

```
bob.pet.speak                 # => "bark!"
bob.pet.fetch                 # => "fetching!"
```

### Representing multiple objects in an array

```ruby
class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = [] # an array to capture our pets
  end
end

bob = Person.new("Robert")

kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty # we include our new pet into our @pets array
bob.pets << bud # we include our Bulldog into our @bud array

bob.pets                      # => [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]
```

Since `bob.pets` is an array, you cannot call `Pet` methods on `pets`.

```
bob.pets.jump                  # NoMethodError: undefined method `jump' for [#<Cat:0x007fd839999620>, #<Bulldog:0x007fd839994ff8>]:Array
```

In order to call methods in the `Pet` class on `pets`, we have to iterate through each item in the array.

```ruby
bob.pets.each do |pet|
  pet.jump
end
```


