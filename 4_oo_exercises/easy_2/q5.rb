# There are a number of variables listed below. What are the different types and how do you know which is which?

excited_dog = "excited dog"
# local variable - unless it is defined in the main scope, it is only accessible at the scope within the method's body when passed in as an arugment
@excited_dog = "excited dog"
# instance variable - accessible by all instance methods, multiple copies are created when there are more than one instance of the class.
@@excited_dog = "excited dog"
# class variable - accessible within the class, only one copy is shared among all instances of the class.