require './helpers/validations'
require './models/hashtag'

module PostError
  class PostInvalidError < ArgumentError
    def message
      'Invalid or undefined required properties'
    end
  end

  class ParentPostNotExists < StandardError
    def message
      'Post commented is not exists or already deleted'
    end
  end

  class UserNotExists < StandardError
    def message
      'User not exists'
    end
  end
end

class Post
  include Validations
  include PostError

  def initialize(post_data = {})
    @id = post_data[:id]
    @username = post_data[:username]
    @text = post_data[:text]
    @timestamp = post_data[:timestamp] || DateTime.now
    @comment_on = post_data[:comment_on]
    @attachment = post_data[:attachment]
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

  def extract_hashtags
    @text.scan(/#(\w+)/).flatten.uniq
  end

  def save(db_con = DatabaseConnection.instance)
    raise PostInvalidError unless valid?

    db_con.transaction do
      save_post
      if include_hashtags?

        hashtags = extract_hashtags
        save_hashtags(hashtags)

        last_inserted_id = 1
        db_con.query('SELECT LAST_INSERT_ID() as id FROM post').each do |last_id|
          last_inserted_id = last_id[:id]
        end

        save_post_hashtags_relation(last_inserted_id, hashtags)
      end
    end
  end

  def save_post(db_con = DatabaseConnection.instance)
    save_query = generate_save_post_query
    db_con.query(save_query)
  rescue Mysql2::Error => e
    raise ParentPostNotExists if e.message.match(/comment_on/)
    raise UserNotExists if e.message.match(/user/)

    raise
  end

  def generate_save_post_query
    query = ''
    query << compose_save_post_query_header
    query << compose_save_post_query_body
    query
  end

  def compose_save_post_query_header
    query_header = ' INSERT INTO post(username, text, timestamp'
    query_header << ', comment_on' unless @comment_on.nil?
    query_header << ', attachment' unless @attachment.nil?
    query_header << ')'
    query_header
  end

  def compose_save_post_query_body
    query_body = " VALUES ('#{@username}', '#{@text}', '#{@timestamp.strftime('%Y-%m-%d %H:%M:%S')}'"
    query_body << ", #{@comment_on}" unless @comment_on.nil?
    query_body << ", '#{@attachment}'" unless @attachment.nil?
    query_body << ')'
    query_body
  end

  def save_hashtags(hashtags, hashtag_model = Hashtag)
    hashtags.each do |hashtag_data|
      hashtag = hashtag_model.new(hashtag: hashtag_data)
      hashtag.save
    end
  end

  def save_post_hashtags_relation(id_post, hashtags, db_con = DatabaseConnection.instance)
    values = gen_post_hashtag_relation_queries(id_post, hashtags)
    db_con.query("INSERT INTO post_have_hashtags(id_post, hashtag)
                  VALUES #{values}")
  end

  def gen_post_hashtag_relation_queries(id_post, hashtags)
    values = ''
    hashtags.each do |hashtag|
      hashtag_value = "(#{id_post}, '#{hashtag}')"
      hashtag_value += ', ' unless hashtag.equal? hashtags.last
      values << hashtag_value
    end
    values
  end

  def to_json(*_args)
    post = {}
    instance_variables.map do |var|
      post[var.to_s.delete '@'] = instance_variable_get(var)
    end
    JSON.dump(post)
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

  def self.where_hashtag(hashtag, db_con = DatabaseConnection.instance)
    raw_posts_data = db_con.query("SELECT * FROM post JOIN post_have_hashtags WHERE post_have_hashtags.hashtag = #{hashtag}")
    parse_raw(raw_posts_data)
  end
end
