# frozen_string_literal: true

require_relative 'base_decorator'

# TrimmerDecorator is a decorator that trims the output to a maximum of 10 characters
class TrimmerDecorator < BaseDecorator
  # Returns the trimmed name by calling the correct_name method of the wrapped object and truncating it to 10 characters
  def correct_name
    super[0..9]
  end
end
