class Hashtag
  attr_reader :occurence, :timestamp

  def initialize(hashtag_data = {})
    @hashtag = hashtag_data[:hashtag]
    @occurence = hashtag_data[:occurence] || 1
    @last_updated = hashtag_data[:last_updated] || Time.now
  end

  def valid?
    return false if @hashtag.nil? || @hashtag.strip.empty?

    true
  end

  def save(db_con = DatabaseConnection.instance)
    return false unless valid?

    db_con.query("INSERT INTO hashtag(hashtag, occurence, last_updated) VALUES ('#{@hashtag}', #{@occurence}, '#{@last_updated.strftime('%Y-%m-%d %H:%M:%S')}')")
  end

  def self.parse_raw(raw_hashtags_data) 
    hashtags = []
    raw_hashtags_data.each do |hashtag_data|
      hashtag = Hashtag.new(hashtag_data)
      hashtags << hashtag
    end
    hashtags
  end

  def self.all(db_con = DatabaseConnection.instance)
    raw_hashtags_data = db_con.query('SELECT * FROM hashtag')
    parse_raw(raw_hashtags_data)
  end
end
