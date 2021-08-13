require './models/post'

class PostController
  def initialize(model = Post)
    @model = model
  end

  def post!(post_data)
    post = @model.new(post_data)
    post.save
  rescue PostError::PostInvalidError => e
    [400, e.message]
  else
    [201]
  end
end
