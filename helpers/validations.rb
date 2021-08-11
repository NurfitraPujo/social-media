module Validations
  def validate_email?(email)
    /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/ === email
  end
end
