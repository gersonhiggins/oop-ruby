require_relative 'book'
require_relative 'person'

# Rental represents a book rental by a person on a specific date.
class Rental
  attr_accessor :date, :book, :person

  # Initializes a new Rental object.
  # date: The date of the rental.
  # book: The book being rented.
  # person: The person renting the book.
  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person

    book.rentals << self
    person.rentals << self
  end
end
