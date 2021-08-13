class Hashtag
  def initialize(hashtag_data = {})
    @hashtag = hashtag_data[:hashtag]
  end

  def valid?
    return false if @hashtag.nil? || @hashtag.strip.empty?

    true
  end
end
