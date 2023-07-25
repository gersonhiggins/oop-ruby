# frozen_string_literal: true

# Nameable is an interface representing objects with a correct_name method.
# All classes that inherit from Nameable should implement this method.
class Nameable
  def correct_name
    raise NotImplementedError, "#{self.class} has not implemented the correct_name method."
  end
end
