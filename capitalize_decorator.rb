require_relative 'base_decorator'

# CapitalizeDecorator is a decorator that capitalizes the output of the wrapped object's correct_name method.
class CapitalizeDecorator < BaseDecorator
  # Returns the capitalized name by calling the correct_name method of the wrapped object.
  def correct_name
    super.capitalize
  end
end
