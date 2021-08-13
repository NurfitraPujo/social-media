module Validations
  def email_valid?(email)
    /[^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+/ === email
  end

  def text_is_empty?(text)
    text.to_s.strip.empty?
  end 
end
