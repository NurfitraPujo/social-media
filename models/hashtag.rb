class Hashtag
  attr_reader :occurence

  def initialize(hashtag_data = {})
    @hashtag = hashtag_data[:hashtag]
    @occurence = 1
  end

  def valid?
    return false if @hashtag.nil? || @hashtag.strip.empty?

    true
  end
end
