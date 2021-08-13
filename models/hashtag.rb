class Hashtag
  attr_reader :occurence, :timestamp

  def initialize(hashtag_data = {})
    @hashtag = hashtag_data[:hashtag]
    @occurence = 1
    @timestamp = Time.now
  end

  def valid?
    return false if @hashtag.nil? || @hashtag.strip.empty?

    true
  end
end
