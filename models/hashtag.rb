class Hashtag
  def initialize(hashtag = '')
    @hashtag = hashtag
  end

  def valid?
    return false if @hashtag.strip.empty?

    true
  end
end
