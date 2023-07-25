# frozen_string_literal: true

require_relative 'nameable'

# Person represents an individual with attributes such as name, age, and parent_permission.
class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  # Initializes a new Person object.
  # age: The age of the person.
  # name: The name of the person (default is 'Unknown').
  # parent_permission: A boolean indicating if the person has parent permission (default is true).
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  # Sets the name of the person.

  # Sets the age of the person.

  # Checks if the person can use certain services based on age or parent permission.
  def can_use_services?
    of_age? || @parent_permission
  end

  # Returns the name of the person.
  def correct_name
    @name
  end

  private

  # Checks if the person is of age (age greater than or equal to 18).
  def of_age?
    @age.to_i >= 18
  end

  # Generates a random ID for the person.
  def generate_id
    rand(1000..9999)
  end
end
