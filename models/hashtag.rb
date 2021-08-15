class Hashtag
  attr_reader :occurence, :timestamp

  def initialize(hashtag_data = {})
    @hashtag = hashtag_data[:hashtag]
    @occurence = 1
    @last_updated = Time.now
  end

  def valid?
    return false if @hashtag.nil? || @hashtag.strip.empty?

    true
  end

  def save(db_con = DatabaseConnection.instance)
    return false unless valid?

    db_con.query("INSERT INTO hashtag(hashtag, occurence, last_updated) VALUES ('#{@hashtag}', #{@occurence}, '#{@last_updated.strftime('%Y-%m-%d %H:%M:%S')}')")
  end


  def self.all(db_con = DatabaseConnection.instance)
    db_con.query('SELECT * FROM hashtag')
  end
end
