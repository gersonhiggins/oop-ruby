require_relative 'nameable'
require_relative 'person'
require_relative 'classroom'
require_relative 'student'
require_relative 'book'
require_relative 'rental'

classroom = Classroom.new('Math')
student1 = Student.new(18, classroom, 'John')
student2 = Student.new(17, classroom, 'Alice')

classroom.add_student(student1)
classroom.add_student(student2)

puts "Classroom: #{classroom.label}"
puts "Students in the classroom: #{classroom.students.map(&:name)}"

book1 = Book.new('Book 1', 'Author 1')
book2 = Book.new('Book 2', 'Author 2')

person1 = Person.new(18, 'John')
person2 = Person.new(17, 'Alice')

Rental.new('2023-07-25', book1, person1)
Rental.new('2023-07-26', book1, person2)
Rental.new('2023-07-27', book2, person1)

puts "Rentals for #{person1.name}: #{person1.rentals.map { |r| "#{r.book.title} (#{r.date})" }}"
puts "Rentals for #{person2.name}: #{person2.rentals.map { |r| "#{r.book.title} (#{r.date})" }}"
