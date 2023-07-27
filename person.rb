require_relative 'nameable'

# Class representing an individual with attributes such as name, age, and parent_permission.
class Person < Nameable
  attr_accessor :age
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(name)
    @id = generate_id
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def add_rental(rental)
    @rentals << rental
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age.to_i >= 18
  end

  def generate_id
    rand(1000..9999)
  end
end
