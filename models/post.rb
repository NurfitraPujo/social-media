require './helpers/validations'

class Post
  include Validations

  def initialize(post_data = {})
    @username = post_data[:username]
    @text = post_data[:text]
  end

  def valid?
    return false if @username.nil?
    return false if @text.nil?
    return false if text_is_empty?(@text)

    true
  end
end