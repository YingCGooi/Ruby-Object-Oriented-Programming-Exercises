# What is the default thing that Ruby will print to the screen if you call to_s on an object? Where could you go to find out if you want to be sure?

# It will be a String object that represents the object.
# The default to_s prints the object's class and encoding of an object id.
# We can find it out by calling #class on #to_s
p to_s.class
