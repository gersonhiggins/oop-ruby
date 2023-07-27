# frozen_string_literal: true

require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'classroom'
require_relative 'teacher'
require_relative 'student'

# Helper method to display a menu and get user choice.
def display_menu
  puts "\nMenu:"
  puts '1. List all books'
  puts '2. List all People'
  puts '3. Create a Person'
  puts '4. Create a Book'
  puts '5. Create a Rental'
  puts '6. List all rentals for a given person'
  puts '7. Exit'
  print "\nEnter your choice (1-7): "
  gets.chomp.to_i
end

# Helper method to get all people (including the ones that were added).
def get_all_people
  # Access the global variable directly to get the created_people array.
  $created_people
end

# Helper method to get all books (including the ones that were added).
def get_all_books
  $created_books
end

# Helper method to create or retrieve a classroom with the given label.
def get_or_create_classroom(label)
  classroom = $all_classrooms.find { |c| c.label == label }
  return classroom if classroom

  classroom = Classroom.new(label)
  $all_classrooms << classroom
  classroom
end

# Helper method to create a new person.
def create_person
  puts "Enter the person's name:"
  name = gets.chomp

  puts "Enter the person's age:"
  age = gets.chomp.to_i

  puts "Enter the person's role (student or teacher):"
  role = gets.chomp.downcase

  if role == 'student'
    puts 'Enter the classroom label for the student:'
    classroom_label = gets.chomp
    classroom = get_or_create_classroom(classroom_label)

    person = Student.new(age, classroom, name)
  elsif role == 'teacher'
    puts "Enter the teacher's specialization:"
    specialization = gets.chomp

    person = Teacher.new(age, specialization, name)
  else
    puts 'Invalid role. Person not created.'
    return
  end

  # Add the created person to the global created_people array.
  $created_people << person

  puts 'Person created successfully!'
end

# Helper method to create a new Book.
def create_book
  print 'Enter the title of the book: '
  title = gets.chomp
  print 'Enter the author of the book: '
  author = gets.chomp
  book = Book.new(title, author)
  puts "Book '#{book.title}' by #{book.author}"

  $created_books << book
end

# Helper method to create a new Rental.
# Helper method to create a new Rental.
def create_rental
  puts 'List of available books:'
  # Assuming you have a method to get all available books.
  # Replace 'get_all_books' with the appropriate method.
  available_books = get_all_books
  if available_books.empty?
    puts 'No books available for rental.'
    return
  end

  available_books.each_with_index { |book, index| puts "#{index + 1}. #{book.title}" }

  print 'Enter the index of the book to rent: '
  book_index = gets.chomp.to_i - 1

  if book_index.negative? || book_index >= available_books.length
    puts 'Invalid book index.'
    return
  end

  selected_book = available_books[book_index]

  puts 'List of people:'
  # Assuming you have a method to get all people.
  # Replace 'get_all_people' with the appropriate method.
  all_people = get_all_people
  if all_people.empty?
    puts 'No people available for rental.'
    return
  end

  all_people.each_with_index { |person, index| puts "#{index + 1}. #{person.name}" }

  print 'Enter the index of the person to rent the book: '
  person_index = gets.chomp.to_i - 1

  if person_index.negative? || person_index >= all_people.length
    puts 'Invalid person index.'
    return
  end

  selected_person = all_people[person_index]

  print 'Enter the rental date (YYYY-MM-DD): '
  date = gets.chomp

  rental = Rental.new(date, selected_book, selected_person)
  puts "Rental created: '#{rental.book.title}' rented by #{rental.person.name} on #{rental.date}."
end

# Helper method to list all rentals for a given person.
def list_rentals_for_person
  puts 'List of people:'
  # Assuming you have a method to get all people.
  # Replace 'get_all_people' with the appropriate method.
  all_people = get_all_people
  all_people.each_with_index { |person, index| puts "#{index + 1}. #{person.name}" }

  print 'Enter the index of the person to view rentals: '
  person_index = gets.chomp.to_i - 1
  selected_person = all_people[person_index]

  puts "Rentals for #{selected_person.name}:"
  selected_person.rentals.each { |rental| puts "#{rental.book.title} (#{rental.date})" }
end

# Initialize an empty array to store the created people.
$created_people = []
$all_classrooms = []
$created_books = []
# Main program loop
loop do
  choice = display_menu

  case choice
  when 1
    # List all books.
    all_books = get_all_books
    all_books.each { |book| puts "#{book.title} by #{book.author}" }
  when 2
    # List all people.
    all_people = get_all_people
    all_people.each do |person|
      if person.is_a?(Student)
        puts "#{person.name} (Age: #{person.age}, Role: Student, Classroom: #{person.classroom.label})"
      elsif person.is_a?(Teacher)
        puts "#{person.name} (Age: #{person.age}, Role: Teacher, Specialization: #{person.specialization})"
      end
    end
  when 3
    # Create a Person.
    create_person
  when 4
    # Create a Book.
    create_book
  when 5
    # Create a Rental.
    create_rental
  when 6
    # List all rentals for a given person.
    list_rentals_for_person
  when 7
    # Exit the program.
    puts 'Exiting...'
    break
  else
    puts 'Invalid choice. Please try again.'
  end
end
