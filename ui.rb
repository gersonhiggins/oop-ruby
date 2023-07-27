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
def all_people
  @all_people ||= []
end

# Helper method to get all books (including the ones that were added).
def all_books
  @all_books ||= []
end

# Helper method to create or retrieve a classroom with the given label.
def get_or_create_classroom(label)
  classroom = @all_classrooms.find { |c| c.label == label }
  return classroom if classroom

  classroom = Classroom.new(label)
  @all_classrooms << classroom
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

  create_person_by_role(role, name, age)
end

  private

def create_person_by_role(role, name, age)
  case role
  when 'student'
    create_student_person(name, age)
  when 'teacher'
    create_teacher_person(name, age)
  else
    puts 'Invalid role. Person not created.'
  end
end

def create_student_person(name, age)
  puts 'Enter the classroom label for the student:'
  classroom_label = gets.chomp
  classroom = get_or_create_classroom(classroom_label)
  person = Student.new(age, classroom, name)
  all_people << person
  puts 'Person created successfully!'
end

def create_teacher_person(name, age)
  puts "Enter the teacher's specialization:"
  specialization = gets.chomp
  person = Teacher.new(age, specialization, name)
  all_people << person
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

  all_books << book
end

# Helper method to create a new Rental.
def create_rental
  puts 'List of available books:'
  return puts 'No books available for rental.' if all_books.empty?

  list_all_books
  selected_book = prompt_for_book
  return unless selected_book

  complete_rental(selected_book)
end

def complete_rental(selected_book)
  puts 'List of people:'
  return puts 'No people available for rental.' if all_people.empty?

  list_all_people
  selected_person = prompt_for_person
  return unless selected_person

  date = prompt_for_rental_date
  create_and_display_rental(selected_book, selected_person, date)
end

def prompt_for_book
  book_index = prompt_for_book_index
  return nil unless book_index

  all_books[book_index]
end

def prompt_for_person
  person_index = prompt_for_person_index
  return nil unless person_index

  all_people[person_index]
end

def create_and_display_rental(book, person, date)
  rental = Rental.new(date, book, person)
  puts "Rental created: '#{rental.book.title}' rented by #{rental.person.name} on #{rental.date}."
end

# Helper method to list all available books.
def list_all_books
  all_books.each_with_index { |book, index| puts "#{index + 1}. #{book.title}" }
end

# Helper method to prompt the user for the book index.
def prompt_for_book_index
  print 'Enter the index of the book to rent: '
  book_index = gets.chomp.to_i - 1

  if book_index.negative? || book_index >= all_books.length
    puts 'Invalid book index.'
    return nil
  end

  book_index
end

# Helper method to list all available people.
def list_all_people
  all_people.each_with_index { |person, index| puts "#{index + 1}. #{person.name}" }
end

# Helper method to prompt the user for the person index.
def prompt_for_person_index
  print 'Enter the index of the person to rent the book: '
  person_index = gets.chomp.to_i - 1

  if person_index == -1
    puts 'Operation canceled.'
    return nil
  elsif person_index.negative? || person_index >= all_people.length
    puts 'Invalid person index.'
    return prompt_for_person_index
  end

  person_index
end

# Helper method to prompt the user for the rental date.
def prompt_for_rental_date
  print 'Enter the rental date (YYYY-MM-DD): '
  gets.chomp
end

# Helper method to list all rentals for a given person.
def list_rentals_for_person
  puts 'List of people:'
  all_people.each_with_index { |person, index| puts "#{index + 1}. #{person.name}" }

  selected_person = select_person
  return unless selected_person

  puts "Rentals for #{selected_person.name}:"
  selected_person.rentals.each { |rental| puts "#{rental.book.title} (#{rental.date})" }
end

# Helper method to select a person based on user input.
def select_person
  print 'Enter the index of the person to view rentals (or 0 to cancel): '
  person_index = gets.chomp.to_i - 1

  if person_index == -1
    puts 'Operation canceled.'
    return nil
  elsif person_index.negative? || person_index >= all_people.length
    puts 'Invalid person index.'
    return select_person
  end

  all_people[person_index]
end

# Initialize an empty array to store the created people.
@created_people = []
@all_classrooms = []
@created_books = []

# Main program loop
loop do
  choice = display_menu

  case choice
  when 1
    # List all books.
    all_books.each { |book| puts "#{book.title} by #{book.author}" }
  when 2
    # List all people.
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
  end
end
