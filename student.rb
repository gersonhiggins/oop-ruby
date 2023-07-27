require_relative 'person'

# Student is a class representing a student, which inherits from Person.
class Student < Person
  attr_accessor :classroom

  # Initializes a new Student object.
  # classroom: The classroom in which the student belongs.
  # name: The name of the student (default is 'Unknown').
  # parent_permission: A boolean indicating if the student has parent permission (default is true).
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  # A method specific to students, which returns "¯\(ツ)/¯".
  def play_hooky
    '¯\\(ツ)/¯'
  end
end
