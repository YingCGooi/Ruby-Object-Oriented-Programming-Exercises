# Given the following code...

# bob = Person.new
# bob.hi
# And the corresponding error message...

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# The method 'hi' is written below the 'private' keyword, making it inaccessible outside of the class. It can be fixed with removing the 'private' keyword, or moving the hi method above the private method.
