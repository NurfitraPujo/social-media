require './helpers/validations'

module PostError
  class PostInvalidError < ArgumentError
    def message
      'Invalid or undefined required properties'
    end
  end
end

class Post
  include Validations
  include PostError

  def initialize(post_data = {})
    @username = post_data[:username]
    @text = post_data[:text]
    @timestamp = post_data[:timestamp]
  end

  def valid?
    return false if @username.nil?
    return false if @text.nil?
    return false if text_is_empty?(@text)
    return false if @timestamp.nil?

    true
  end

  def include_hashtags?
    @text.include?('#')
  end

  def save(db_con = DatabaseConnection.instance)
    raise PostInvalidError unless valid?

    db_con.query("INSERT INTO post(username, text, timestamp) VALUES ('#{@username}','#{@text}','#{@timestamp.strftime('%Y-%m-%d %H:%M:%S')}')")
  end

  def self.parse_raw(raw_posts_data)
    posts = []
    raw_posts_data.each do |post_data|
      post = Post.new(post_data)
      posts << post
    end
    posts
  end

  def self.all(db_con = DatabaseConnection.instance)
    raw_posts_data = db_con.query('SELECT * FROM post')
    parse_raw(raw_posts_data)
  end
end
