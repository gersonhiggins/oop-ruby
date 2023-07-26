require_relative 'student'

# Classroom represents a classroom with a label and a list of students.
class Classroom
  attr_reader :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  # Adds a student to the classroom.
  def add_student(student)
    @students << student unless @students.include?(student)
    student.classroom = self
  end
end
