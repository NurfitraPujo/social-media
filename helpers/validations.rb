module Validations
  def email_valid?(email)
    /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/ === email
  end
end
