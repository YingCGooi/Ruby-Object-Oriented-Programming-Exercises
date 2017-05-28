### What is the method lookup path and how is it important?

Method lookup path is the sequence in which the methods will be called in case of the presence of multiple same-name methods. When calling a method, Ruby will traverse up the chain of super-classes until the first method is called. We can call `ancestors` method on a child class to determine its method lookup path.