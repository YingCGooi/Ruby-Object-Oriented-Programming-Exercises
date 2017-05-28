class Student
  attr_writer :name, :grade

  def initialize(grade)
    @grade = grade
    @name = name
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end

  private
  attr_reader :name, :grade
end

p joe = Student.new(90)
p bob = Student.new(80)
puts "Well done!" if joe.better_grade_than?(bob)

