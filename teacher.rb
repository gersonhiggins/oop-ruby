# frozen_string_literal: true

require_relative 'person'

# Teacher is a class representing a teacher, which inherits from Person.
class Teacher < Person
  # Initializes a new Teacher object.
  # specialization: The area of specialization for the teacher.
  def initialize(age, specialization, name = 'Unknown')
    super(age, name)
    @specialization = specialization
  end

  # Overrides the can_use_services? method to always return true for teachers.
  def can_use_services?
    true
  end
end
