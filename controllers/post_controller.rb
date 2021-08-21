require './models/post'
require './helpers/parser'

class PostController
  include Parser

  def initialize(model = Post)
    @model = model
  end

  def post!(post_data)
    post = @model.new(post_data)
    post.save
  rescue PostError::PostInvalidError => e
    [400, e.message]
  rescue PostError::ParentPostNotExists => e
    [404, e.message]
  else
    [201]
  end

  def search(search_params)
    return [400, 'No search parameters given'] if search_params.empty? || search_params[:hashtag].nil?

    posts = @model.where_hashtag(search_params[:hashtag])
    [200, to_json_arr(posts)]
  end
end
