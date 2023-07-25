require_relative 'nameable'

# BaseDecorator is a base class for all decorators.
# It implements the Nameable interface and delegates the correct_name method to the wrapped object.
class BaseDecorator < Nameable
  # Initializes a new BaseDecorator with a nameable object to be wrapped.
  def initialize(nameable)
    super
    @nameable = nameable
  end

  # Delegates the correct_name method to the wrapped object.
  def correct_name
    @nameable.correct_name
  end
end
