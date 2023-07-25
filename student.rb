# frozen_string_literal: true

require_relative 'person'

# Student is a class representing a student, which inherits from Person.
class Student < Person
  # Initializes a new Student object.
  # classroom: The classroom in which the student belongs.
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  # A method specific to students, which returns "¯\(ツ)/¯".
  def play_hooky
    '¯\\(ツ)/¯'
  end
end
