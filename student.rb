# Student is a class representing a student, which inherits from Person.
class Student < Person
  def initialize(age, _classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
