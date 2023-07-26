# Nameable represents an entity with a name.
class Nameable
  attr_accessor :name

  def initialize(name = 'Unknown')
    @name = name
  end

  # Method that should be implemented by subclasses to return the correct name.
  def correct_name
    raise NotImplementedError, 'Subclasses must implement the correct_name method.'
  end
end
